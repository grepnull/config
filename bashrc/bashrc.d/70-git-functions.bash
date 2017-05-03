function git-gone {
    git branch -vv --sort='committerdate' | grep ": gone]" | awk '{print $1}'
}

function git-merged {
    # actually merged branches
    git branch --merged origin/master --sort='committerdate' | grep -v '\\*' | grep -Ev '^  master$'
    # branches that whose upstream was deleted. Indication that the branch was "squash and merged"
    # on github
    local origin=$(git remote get-url origin)
    local merge_cache=~/.github_merge_cache
    if [[ "${origin}" =~ "git@github.com" ]]; then
        local github_uri=$(echo $origin | sed "s/^git@github.com://" | sed "s/.git$//")
        local github_repo_user=$(echo $github_uri | sed "s#/.*##")
        local gone=$(git-gone)
        local github_merged=""
        for branch in $gone; do
            local merged="false"
            #echo "Checking if $branch was merged in cache"
            touch $merge_cache
            if grep --quiet --line-regexp $branch $merge_cache; then
                merged="true"
            fi
            if [[ "$merged" != "true" ]]; then
                #echo "Checking if $branch was merged in github in $github_uri"
                http --auth vincer:${GITHUB_AUTH_TOKEN} "https://api.github.com/repos/$github_uri/pulls?head=$github_repo_user:${branch}&state=all" | jq --exit-status --raw-output .[0].merged_at > /dev/null
                if [[ $? == 0 ]]; then
                    merged="true"
                    echo $branch >> $merge_cache
                fi
            fi
            if [[ "$merged" == "true" ]]; then
                github_merged="${github_merged}\n$branch"
            fi
        done
        if [[ "${github_merged}" ]]; then
            echo -e "$github_merged"
        fi
    fi
}

function git-clean-merged {
    local merged=$(git-merged)
    if [ "$merged" ]; then
        echo "$merged"
        read -p 'Delete these branches? ' -r
        if [ "$REPLY" == "y" ]; then
            git branch -D $merged
        else
            echo 'Aborted.'
        fi
    else
        echo 'No merged branches to delete.';
    fi

    return 0
}

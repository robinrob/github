$LOAD_PATH << '.'

require 'github'

github = Github.new "robinrob", "7lgnjsl3"
github.import
# github.save_repo_slugs_to_file
# github.delete_repo "the-blob"
# github.delete_repo "prototype-x"
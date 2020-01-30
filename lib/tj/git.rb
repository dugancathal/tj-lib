module Git
  module_function
  def fetch_changes
    `git fetch origin`
  end

  def current_branch
    `git rev-parse --abbrev-ref HEAD`.chomp 
  end

  def pull_dev
    `git pull -r origin development` 
  end

  def rebase_current_to_dev
    `git rebase origin/development`
  end

  def current_branch_clean?
    `git status --porcelain`.empty?
  end
end

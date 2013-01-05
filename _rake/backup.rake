deploy_branch  = "master"

desc "backup to GitHub"
multitask :backup do
  puts "\n## Backing up to GitHub"
  system "git add ."
  system "git add -u"
  message = "Site updated at #{Time.now.utc}"
  system "git commit -m '#{message}'"
  system "git push origin #{deploy_branch}"
  puts "\n## GitHub backup complete"
end
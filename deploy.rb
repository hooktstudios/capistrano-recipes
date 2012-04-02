after 'deploy:symlink' do
  run "echo #{stage} > #{File.join release_path, 'STAGE'}"
end

after 'deploy:create_symlink' do
  run "echo #{stage} > #{File.join release_path, 'STAGE'}"
end

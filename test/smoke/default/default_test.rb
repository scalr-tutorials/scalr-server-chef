

%w(gnupg curl apt-transport-https debian-archive-keyring).each do |pkg|
  describe package(pkg) do
    it { should be_installed }
    #      # its('version') { should eq '1.9.5' }
  end
end

describe directory '/etc/scalr-server/' do
  it { should be_directory }
end

describe package('scalr-server') do
  it { should be_installed }
  its('version') { should eq '7.8.0.enterprise.xenial.b258-1' }
end

describe file('/etc/scalr-server/license.json') do
  it { should exist }
end

describe file('/etc/scalr-server/scalr-server.rb') do
  it { should exist }
end

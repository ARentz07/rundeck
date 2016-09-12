require 'spec_helper'

describe service('rundeckd') do
  it { should be_running }
end

files = ['/etc/rundeck/jaas-activedirectory.conf', '/var/lib/rundeck/exp/webapp/WEB-INF/web.xml', '/etc/rundeck/jaas-activedirectory.conf', '/etc/rundeck/profile', '/etc/rundeck/framework.properties','/etc/rundeck/realm.properties']

describe file('/var/lib/rundeck') do
  it { should be_directory }
  it { should exist }
  it { should be_owned_by 'rundeck' }
  it { should be_grouped_into 'rundeck' }
end

describe file('/var/lib/rundeck/projects') do
  it { should be_directory }
  it { should exist }
  it { should be_owned_by 'rundeck' }
  it { should be_grouped_into 'rundeck' }
end

describe file('/var/lib/rundeck/.chef') do
  it { should be_directory }
  it { should exist }
  it { should be_owned_by 'rundeck' }
  it { should be_grouped_into 'rundeck' }
  it { should be_mode 700 }
end

describe file('/var/lib/rundeck/.chef/knife.rb') do
  it { should be_file }
  it { should exist }
  it { should be_owned_by 'rundeck' }
  it { should be_grouped_into 'rundeck' }
  its (:content) { should match (/node_name\s*'rundeck'/) }
  its (:content) { should match ('chef_server_url') }
end

describe file('/var/lib/rundeck/.ssh') do
  it { should be_directory }
  it { should exist }
  it { should be_owned_by 'rundeck' }
  it { should be_grouped_into 'rundeck' }
  it { should be_mode 700 }
end

describe file('/var/lib/rundeck/.ssh/id_rsa') do
  it { should be_file }
  it { should exist }
  it { should be_owned_by 'rundeck' }
  it { should be_grouped_into 'rundeck' }
  it { should be_mode 600 }
  its (:content) { should match(/\W/) }
end

describe file('/var/lib/rundeck/libext/rundeck-winrm-plugin-1.3.1.jar') do
  it { should be_file }
  it { should exist }
  it { should be_owned_by 'rundeck' }
  it { should be_grouped_into 'rundeck' }
  it { should be_mode 644 }
end

describe file('/etc/rundeck/rundeck-config.properties') do
  it { should be_file }
  it { should exist }
  it { should be_owned_by 'rundeck' }
  it { should be_grouped_into 'rundeck' }
  its (:content) { should_not match(/dataSource.url\s*=\s*jdbc:mysql:\/\/someIPorFQDN:3306\/rundeckdb\?autoReconnect=true/) }
  its (:content) { should_not match(/dataSource.username\s*=\s*\w/) }
  its (:content) { should_not match(/dataSource.password\s*=\s*\w/) }
end

files.each do |file|
  describe file(file) do
    it { should be_file }
    it { should exist }
    it { should be_owned_by 'rundeck' }
    it { should be_grouped_into 'rundeck' }
  end
end

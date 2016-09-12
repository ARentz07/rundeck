require 'spec_helper'

describe file('/etc/rundeck/rundeck-config.properties') do
  it { should be_file }
  it { should exist }
  it { should be_owned_by 'rundeck' }
  it { should be_grouped_into 'rundeck' }
  its(:content) { should match(/dataSource.url\s*=\s*jdbc:mysql:\/\/someIPorFQDN:3306\/rundeckdb\?autoReconnect=true/) }
  its(:content) { should match(/dataSource.username\s*=\s*\w/) }
  its(:content) { should match(/dataSource.password\s*=\s*\w/) }
end

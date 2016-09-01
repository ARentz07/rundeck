require 'spec_helper'

describe file('/etc/rundeck/rundeck-config.properties') do
  it { should be_file }
  it { should exist }
  it { should be_owned_by 'rundeck' }
  it { should be_grouped_into 'rundeck' }
  it { should contain(/dataSource.url = jdbc:mysql:\/\/someIPorFQDN:3306\/rundeckdb?autoReconnect=true/) }
  it { should contain(/dataSource.username = \w/) }
  it { should contain(/dataSource.password = \w/) }
end

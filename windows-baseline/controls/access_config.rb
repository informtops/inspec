# encoding: utf-8


control 'windows-base-100' do
  impact 1.0
  title 'Verify the Windows folder permissions are properly set'
  describe file('c:/windows') do
    it { should be_directory }
    # it { should_not be_readable }
    # it { should_not be_writable.by('Administrator') }
  end
end

## NTLM

control 'windows-base-101' do
  impact 1.0
  title 'Safe DLL Search Mode is Enabled'
  desc '
    cannot be managed via group policy
    @link: https://msdn.microsoft.com/en-us/library/ms682586(v=vs.85).aspx
    @link: https://technet.microsoft.com/en-us/library/dd277307.aspx
  '
  describe registry_key('HKLM\System\CurrentControlSet\Control\Session Manager') do
    it { should exist }
    it { should_not have_property_value('SafeDllSearchMode', :type_dword, '0') }
  end
end
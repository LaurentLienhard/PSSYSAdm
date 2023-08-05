Import-Module PSSYSAdm -force

Describe "Get-RemoteRDPSession" {
    Context "When calling the function without any parameters" {
        It "Should throw an error for missing parameters" {
            { Get-RemoteRDPSession } | Should -Throw
        }
    }

    Context "When querying a remote computer with active RDP sessions" {
        BeforeAll {

                    # Mock the quser command to simulate its output
#             Mock -CommandName 'quser' -MockWith { @"
# USERNAME              SESSIONNAME        ID  STATE   IDLE TIME  LOGON TIME
# User1                 RDP-Tcp#1          2  Active          00:01  08/05/2023 10:00 AM
# User2                 RDP-Tcp#2          3  Active          00:05  08/05/2023 09:30 AM
# "@ }

            Mock -CommandName Get-RemoteRDPSession -MockWith {
                return @(
                    ' USERNAME              SESSIONNAME        ID  STATE   IDLE TIME  LOGON TIME',
                    '>user1                 rdp-tcp#0           1  Active          00:01  03/08/2023 08:00',
                    ' user2                                   2  Disc          00:00  03/08/2023 09:00',
                    ' user3                                   3  Active         01:30  03/08/2023 10:00'
                )
            }
        }

        It "Should return the list of RDP sessions" {
            $result = Get-RemoteRDPSession
            $result | Should -Not -BeNullOrEmpty
            $result | Should -HaveCount 4
        }
    }
}

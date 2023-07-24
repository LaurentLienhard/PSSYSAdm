ENUM LOGONTYPE {
    INTERACTIVE_happens_when_a_user_logs_on_to_the_computer = 2
    NETWORK_user_or_computer_logs_on_to_the_computer_from_the_network = 3
    BATCH_Scheduled_tasks_are_executed_on_behalf_of_a_user = 4
    SERVICE_services_and_service_accounts_that_logon_to_run_a_service = 5
    UNLOCK_when_a_user_unlocks_their_machine = 6
    NETWORKCLEARTEXT_password_was_passed_in_plaintext = 8
    NEWCREDENTIALS_user_uses_the_RunAs_command = 9
    REMOTEINTERACTIVE_user_remotely_accesses_the_computer_through_RDP_applications = 10
    CACHEDINTERACTIVE_user_logons_to_the_computer_without_having_to_contact_the_domain_controller = 11
}

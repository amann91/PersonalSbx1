public with sharing class testSharing {
    List<Account> acctWSharing = [SELECT Id, Name, Industry FROM Account];
        
    
    
        private without sharing class testInnerWoSharing{
            
            private List<Account> getPrivateAccounts(){
                return
                    [SELECT Id, Name, Industry FROM Account];
                
            }    
        }
}
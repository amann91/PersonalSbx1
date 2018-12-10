public class CrewCompTrackingController {
    
    @AuraEnabled
    public static Map<Id, List<mann__Crew_Member_Competency__c>> getCrewComps(){
        Map<Id, List<mann__Crew_Member_Competency__c>> crewMemberMap = new Map<Id, List<mann__Crew_Member_Competency__c>>();
        List<mann__Crew_Member_Competency__c> crewMemberComps = [SELECT Id,mann__Competency__c,mann__Crew_Member__c,mann__Latest_Certification_Date__c,mann__Refresh_Freq_Years__c,mann__Status__c 
                                                                 FROM mann__Crew_Member_Competency__c ORDER BY mann__Crew_Member__c ASC];
        
        Id crewMember;
        for(mann__Crew_Member_Competency__c cm : crewMemberComps){
            if(crewMember != cm.mann__Crew_Member__c){
                crewMember = cm.mann__Crew_Member__c;
                List<mann__Crew_Member_Competency__c> comps = [SELECT mann__Competency__c, mann__Crew_Member__c, mann__Latest_Certification_Date__c, mann__Refresh_Freq_Years__c, mann__Status__c
                                                               FROM mann__Crew_Member_Competency__c WHERE mann__Crew_Member__c = :crewMember];
                
                crewMemberMap.put(crewMember, comps);
            }
            
        }
        system.debug(crewMemberMap);
        return crewMemberMap;
    }
    
    @AuraEnabled
    public static List<mann__Crew_Member_Competency__c> getCrewComps1(){
        return [SELECT Id,mann__Competency__c,mann__Competency__r.Name,mann__Crew_Member__r.Name,mann__Latest_Certification_Date__c,mann__Refresh_Freq_Years__c,mann__Status__c 
                FROM mann__Crew_Member_Competency__c ORDER BY mann__Crew_Member__c ASC];
    }
    
    @AuraEnabled
    public static List<String> getAllCrewMembers(){
        //return [SELECT Id,mann__Competency__c,mann__Competency__r.Name,mann__Crew_Member__r.Name,mann__Latest_Certification_Date__c,mann__Refresh_Freq_Years__c,mann__Status__c 
        //FROM mann__Crew_Member_Competency__c ORDER BY mann__Crew_Member__c ASC];
        List<mann__Crew_Member__c> crewMems = [SELECT Name FROM mann__Crew_Member__c ORDER BY Name ASC];
        
        List<String> crewNames = new List<String>();
        for(mann__Crew_Member__c cm : crewMems){
            crewNames.add(cm.Name);  
        }
        
        return crewNames;
    }
    
    @AuraEnabled
    public static List<String> getAllComps(){
        List<mann__Competency__c> comps = [SELECT Name FROM mann__Competency__c ORDER BY Name ASC];
        
        List<String> compNames = new List<String>();
        for(mann__Competency__c c : comps){
            compNames.add(c.Name);  
        }
        
        return compNames;
    }
    
    @AuraEnabled
    public static Map<Integer, List<String>> getAllCrewCompStatus(){
    	List<String> allCrewMembers = getAllCrewMembers();
        List<String> allComps= getAllComps();
        List<mann__Crew_Member_Competency__c> crewComps = [SELECT Id
                                                     ,mann__Competency__c
                                                     ,mann__Competency__r.Name
                                                     ,mann__Crew_Member__r.Name
                                                     ,mann__Latest_Certification_Date__c
                                                     ,mann__Refresh_Freq_Years__c
                                                     ,mann__Status__c 
                                                     FROM mann__Crew_Member_Competency__c];
       	
        Map<String, String> mapCrewToComp = new Map<String, String>();
        List<List<String>> compStatus = new List<List<String>>();
        Map<Integer, List<String>> compStatusTest1 = new Map<Integer, List<String>>();
        
        Set<String> setArray = new Set<String> {'S','D', 'C', '-', ' '};
            List<String> lstArray = new List<String>();
        lstArray.addAll(setArray);
        List<String> testCompsStatus = new List<String>();
        for(Integer c = 0; c < allCrewMembers.size(); c++){
            List<String> newCompListPerCrewMember = new List<String>();
            for(Integer i = 0; i < allComps.size(); i++){
                system.debug('Comp Size: ' + allComps.size());
                //Generate a random list index
                Double randomNumber = Math.random();
                Integer arrayLength = lstArray.size();
                Integer randomIndex = (randomNumber *(arrayLength-1)).intValue();
                //Output the element at the list index generated above
                newCompListPerCrewMember.add(lstArray[randomIndex]);
            }
            system.debug('testCompsStatus: ' + testCompsStatus.size());
            compStatusTest1.put(c, newCompListPerCrewMember);
        }
        return compStatusTest1;
       
            /*List<String> statuses = new List<String>{'C', 'S', '-'};
                List<String> statuses1 = new List<String>{'C', 'S', '-'};
                    List<String> statuses2 = new List<String>{'C', 'S', '-'};
                        compStatus.add(statuses);
        compStatus.add(statuses1);
        compStatus.add(statuses2);*/
        /*for(String cm : allCrewMembers){
            for(String c : allComps){
                for(mann__Crew_Member_Competency__c cmp : crewComps){
                    if(cmp.mann__Crew_Member__r.Name == cm){}
                }
            }
        }*/
    }
    
    @AuraEnabled
    public static List<String> getCrewMemberNames(){
        Set<String> cmNamesSet = new Set<String>();
        List<String> cmNames = new List<String>();
        List<mann__Crew_Member_Competency__c> cms = [SELECT Id,mann__Competency__c,mann__Competency__r.Name,mann__Crew_Member__r.Name,mann__Latest_Certification_Date__c,mann__Refresh_Freq_Years__c,mann__Status__c 
                                                     FROM mann__Crew_Member_Competency__c ORDER BY mann__Crew_Member__c ASC];
        
        for(mann__Crew_Member_Competency__c cmc : cms){
            cmNamesSet.add(cmc.mann__Crew_Member__r.Name);
        }
        cmNames.addAll(cmNamesSet);
        return cmNames;
    }
    
    @AuraEnabled
    public static List<String> getComps(){
        Set<String> cpNamesSet = new Set<String>();
        List<String> cmNames = new List<String>();
        List<mann__Crew_Member_Competency__c> cms = [SELECT Id,mann__Competency__c,mann__Competency__r.Name,mann__Crew_Member__r.Name,mann__Latest_Certification_Date__c,mann__Refresh_Freq_Years__c,mann__Status__c 
                                                     FROM mann__Crew_Member_Competency__c ORDER BY mann__Crew_Member__c ASC];
        
        for(mann__Crew_Member_Competency__c cmc : cms){
            cpNamesSet.add(cmc.mann__Competency__r.Name);
        }
        cmNames.addAll(cpNamesSet);
        return cmNames;
    }
    
    @AuraEnabled
    public static String getreport(){
        //Using report id for example purpose
        Report reportRec = [SELECT
                            Id
                            FROM Report
                            WHERE Id = '00O1I000006PTpR'];
        
        Reports.ReportResults reportResult =
            Reports.ReportManager.runReport(reportRec.Id, true);
        
        return JSON.serialize(reportResult);
    }
}
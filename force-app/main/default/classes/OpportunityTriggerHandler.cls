public class OpportunityTriggerHandler {
    
    public static void updateDefaultAccount(List<Opportunity> newList, Map<ID, Opportunity> oldMap){
        List<Account> accountList = new List<Account>();
        accountList = [SELECT Id FROM Account WHERE Name = 'Default Account Test' LIMIT 1];
        for(Opportunity opp : newList){
            if(opp.AccountId == Null && accountList.size()>0){
                opp.AccountId = accountList.get(0).Id;
            }
        }
    }
    
    public static void findDuplicate(List<Opportunity> newList, Map<ID, Opportunity> oldMap){
        Set<String> oppNameSet = new Set<String>();
        Set<Id> oppAccountIdSet = new Set<Id>();
        Set<Id> oppRecordTypeIdSet = new Set<Id>();
        Set<Date> oppCloseDateSet = new Set<Date>();
        Set<String> uniqueKeySet = new Set<String>();
        for(Opportunity opp : newList){
            if(oldMap == Null || (opp.Name != oldMap.get(opp.Id).Name
                                  || opp.RecordTypeId != oldMap.get(opp.Id).RecordTypeId
                                  || opp.CloseDate != oldMap.get(opp.Id).CloseDate
                                  || opp.AccountId != oldMap.get(opp.Id).AccountId)){
                                      oppNameSet.add(opp.Name);
                                      oppAccountIdSet.add(opp.AccountId);
                                      oppRecordTypeIdSet.add(opp.RecordTypeId);
                                      oppCloseDateSet.add(opp.CloseDate);
                                  }
            
        }
        
        for(Opportunity opp : [SELECT Id, Name, AccountId, RecordTypeId, CloseDate
                               FROM Opportunity
                               WHERE Name IN :oppNameSet 
                               AND AccountId IN :oppAccountIdSet
                               AND RecordTypeId IN :oppRecordTypeIdSet
                               AND CloseDate IN :oppCloseDateSet]){
                                   String key = (opp.Name + '-' + opp.AccountId + '-' + opp.RecordTypeId + '-' + String.valueOf(opp.CloseDate)).toLowerCase();
                                   uniqueKeySet.add(key);
                                   
                               }
        
        //List<Application_Message__mdt> mcs = Application_Message__mdt.getAll().values();
        //Map<String, Application_Message__mdt> mcs = Application_Message__mdt.getAll();
        Application_Message__mdt mc = Application_Message__mdt.getInstance('OpportunityError');
        for(Opportunity opp : newList){
            if(oldMap == Null || (opp.Name != oldMap.get(opp.Id).Name
                                  || opp.RecordTypeId != oldMap.get(opp.Id).RecordTypeId
                                  || opp.CloseDate != oldMap.get(opp.Id).CloseDate
                                  || opp.AccountId != oldMap.get(opp.Id).AccountId)){
                                      String key = (opp.Name + '-' + opp.AccountId + '-' + opp.RecordTypeId + '-' + String.valueOf(opp.CloseDate)).toLowerCase();
                                      if(uniqueKeySet.contains(key)){
                                          opp.addError(mc.Message__c);
                                      }
                                      else{
                                          uniqueKeySet.add(key);
                                      }
                                  }
        }
    }
    
    public static void dealsOwnedByUser(List<Opportunity> newList, Map<Id, Opportunity> oldMap){
        Set<ID> userIdSet = new Set<ID>();
        Set<String> stageSet = new Set<String>();
        Set<Integer> monthSet = new Set<Integer>();
        Set<Integer> yearSet = new Set<Integer>();
        Set<String> monthYearSet = new Set<String>();
        Map<String, Decimal> stageMonthlyAmountMap = new Map<String, Decimal>();
        String uniqueKey;
        if(newList != Null){
            for(Opportunity opp : newList){
                if(oldMap == Null){
                    userIdSet.add(opp.OwnerId);
                    stageSet.add(opp.StageName);
                    yearSet.add(opp.CloseDate.year());
                    monthSet.add(opp.CloseDate.month());
                    monthYearSet.add('('+String.valueOf(opp.CloseDate.month()) + '/' + String.valueOf(opp.CloseDate.year())+')');
                    System.debug(opp);
                    uniqueKey = opp.OwnerId + ' - ' + opp.StageName + ' - (' + String.valueOf(opp.CloseDate.month()) + '/' + String.valueOf(opp.CloseDate.year())+')';
                    if(!stageMonthlyAmountMap.containsKey(uniqueKey)){
                        stageMonthlyAmountMap.put(uniqueKey, 0);
                    }
                }
                else if(oldMap != Null || opp.OwnerId != oldMap.get(opp.Id).OwnerId
                        || opp.CloseDate != oldMap.get(opp.Id).CloseDate
                        || opp.Amount != oldMap.get(opp.Id).Amount
                        || opp.StageName != oldMap.get(opp.Id).StageName){
                            System.debug('-------');
                            userIdSet.add(oldMap.get(opp.Id).OwnerId);
                            stageSet.add(oldMap.get(opp.Id).StageName);
                            yearSet.add(oldMap.get(opp.Id).CloseDate.year());
                            monthSet.add(oldMap.get(opp.Id).CloseDate.month());
                            monthYearSet.add('('+String.valueOf(oldMap.get(opp.Id).CloseDate.month()) + '/' + String.valueOf(oldMap.get(opp.Id).CloseDate.year())+')');
                            uniqueKey = oldMap.get(opp.Id).OwnerId + ' - ' + oldMap.get(opp.Id).StageName + ' - (' + String.valueOf(oldMap.get(opp.Id).CloseDate.month()) + '/' + String.valueOf(oldMap.get(opp.Id).CloseDate.year())+')';
                            if(!stageMonthlyAmountMap.containsKey(uniqueKey)){
                                stageMonthlyAmountMap.put(uniqueKey, 0);
                            }
                        }
            }
        }
        else{
            for(ID oppId : oldMap.keySet()){
                userIdSet.add(oldMap.get(oppId).OwnerId);
                stageSet.add(oldMap.get(oppId).StageName);
                yearSet.add(oldMap.get(oppId).CloseDate.year());
                monthSet.add(oldMap.get(oppId).CloseDate.month());
                monthYearSet.add('('+String.valueOf(oldMap.get(oppId).CloseDate.month()) + '/' + String.valueOf(oldMap.get(oppId).CloseDate.year())+')');
                uniqueKey = oldMap.get(oppId).OwnerId + ' - ' + oldMap.get(oppId).StageName + ' - (' + String.valueOf(oldMap.get(oppId).CloseDate.month()) + '/' + String.valueOf(oldMap.get(oppId).CloseDate.year())+')';
                if(!stageMonthlyAmountMap.containsKey(uniqueKey)){
                    stageMonthlyAmountMap.put(uniqueKey, 0);
                }
            }
        }
        
        System.debug(stageMonthlyAmountMap);
        for(AggregateResult aggr : [SELECT OwnerId, StageName, CALENDAR_MONTH(CloseDate) Month, CALENDAR_YEAR(CloseDate) Year, SUM(Amount)
                                    FROM Opportunity
                                    WHERE OwnerId IN :userIdSet
                                    AND StageName IN :stageSet
                                    AND CALENDAR_MONTH(CloseDate) IN :monthSet
                                    AND CALENDAR_YEAR(CloseDate) IN :yearSet
                                    GROUP BY OwnerId, StageName, CALENDAR_MONTH(CloseDate), CALENDAR_YEAR(CloseDate)]){
                                        String stageWiseMonthly = aggr.get('OwnerId') + ' - ' + aggr.get('StageName') + ' - (' + String.valueOf(aggr.get('Month')) + '/' + String.valueOf(aggr.get('Year')) + ')';
                                        
                                        if(String.valueOf(aggr.get('expr0')) == Null){
                                            stageMonthlyAmountMap.put(stageWiseMonthly, 0);
                                        }
                                        //if(stageMonthlyAmountMap.containsKey(stageWiseMonthly))
                                        else{
                                            String tempString = String.valueOf(aggr.get('expr0'));
                                            stageMonthlyAmountMap.put(stageWiseMonthly, Decimal.valueOf(tempString));
                                        }
                                        System.debug(aggr);
                                        System.debug(stageMonthlyAmountMap);
                                    }
        
        
        if(stageMonthlyAmountMap.size()>0){
            Map<String, Opportunity_Report__c> oppReportMap = new Map<String, Opportunity_Report__c>();
            List<Opportunity_Report__c> oppReportList = new List<Opportunity_Report__c>();
            for(Opportunity_Report__c oppReport : [SELECT User_Id__c, Stage_Name__c, Month_Year__c, Total_Amount__c FROM Opportunity_Report__c 
                                                   WHERE User_Id__c IN :userIdSet                              
                                                   AND Stage_Name__c IN :stageSet
                                                   AND Month_Year__c IN :monthYearSet]){
                                                       String oppRep = oppReport.User_Id__c + ' - ' + oppReport.Stage_Name__c + ' - ' + oppReport.Month_Year__c;
                                                       System.debug(oppReport);
                                                       if(!oppReportMap.containsKey(oppRep)){
                                                           oppReportMap.put(oppRep, oppReport);
                                                       }
                                                   }
            
            for(String s : stageMonthlyAmountMap.keySet()){
                if(oppReportMap.containsKey(s)){
                    Opportunity_Report__c oppReport = new Opportunity_Report__c();
                    oppReport.Id = oppReportMap.get(s).Id;
                    oppReport.Total_Amount__c = stageMonthlyAmountMap.get(s);
                    oppReportList.add(oppReport);
                    System.debug(oppReportList);
                }
                else{
                    List<String> mapToString = s.split('-');
                    System.debug(mapToString);
                    oppReportList.add(new Opportunity_Report__c(User_Id__c = mapToString[0], Stage_Name__c = mapToString[1], Month_Year__c = mapToString[2], Total_Amount__c = stageMonthlyAmountMap.get(s)));
                }
            }
            UPSERT oppReportList;
        }
    }
}
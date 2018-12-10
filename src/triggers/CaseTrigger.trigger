trigger CaseTrigger on Case(after insert, after update) {

	//if (trigger.isUpdate) {

		for (Case c : trigger.new) {
			system.debug('Look at this case!! ' + c);
			//CaseHandler(c);
			//List<Case> caseList = new CaseHandler(c);
		}

		
		//List<Case> returnedList = ctrl.getCases();

	//}

}
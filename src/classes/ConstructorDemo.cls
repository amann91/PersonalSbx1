public class ConstructorDemo {
	integer value1;
	integer value2;
	public List<Case> caseList { get; set; }
	String myString;

	public ConstructorDemo() {
		value1 = 10;
		this.value2 = 20;
		System.debug('Inside Constructor');
		integer i;
		myString = 'Hey guys I know how to CONSTRUCTOR!! ' + value1;
		Case c3 = new Case();
		c3.Subject = 'Placeholder Case';
		//caseList.add(c3);
	}

	public PageReference getCases() {
		List<Case> aList = [SELECT Id, Subject, Origin FROM Case];
		List<Case> modifiedList = new List<Case> ();
		for (Case c : aList) {
			if (c.Origin != 'Phone') {
				c.Subject = c.Subject + ' :used to be ' + c.Origin;
				c.Origin = 'Phone';
				modifiedList.add(c);
			}
			else { modifiedList.add(c); }
		}

		List<Case> modifiedList1 = modifyCases(modifiedList);
		caseList = modifiedList1;
		return null;
	}

	private static List<Case> modifyCases(List<Case> someCases) {
		List<Case> casesList = new List<Case> ();
		for (Case c2 : someCases) {
			c2.Subject = c2.Subject + ' Added Subject matter';
			casesList.add(c2);
		}
		return casesList;
	}
}
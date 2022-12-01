package criTest;

import lombok.Data;

@Data
public class SearchCriteria extends Criteria {
	
	private String searchType;
	private String keyword;
	private String keyword2;
	private String[] check;
	
	private String id;

} //class

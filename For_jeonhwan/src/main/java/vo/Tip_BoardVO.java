package vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Tip_BoardVO {
	private int seq;
	private String title;
	private String id;
	private String content;
	private String regdate;
	private int cnt;
	private int root;
	private int step;
	private int indent;
	private String uploadfile; 
	// => Table에 저장 및 view 처리를 위한 필드 (저장값: 경로및 화일명) 
	//    Table의 컬럼명과 일치
	private MultipartFile uploadfilef;
	// => UI_form 의 Upload_Image 정보를 전달받기위한 필드
	//    MultipartFile (Interface) -> CommonsMultipartFile
	//    UI 의 Tag 의 name 속성과 일치
}

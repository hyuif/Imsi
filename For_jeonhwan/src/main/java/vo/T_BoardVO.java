package vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class T_BoardVO {
	private int seq;
	private String title;
	private String id;
	private String content;
	private String regdate;
	private int cnt;
	private int root;
	private int step;
	private int indent;
	private String[] check;
	private String trade;
	private String uploadfile;
	private MultipartFile uploadfilef;
	
} //class

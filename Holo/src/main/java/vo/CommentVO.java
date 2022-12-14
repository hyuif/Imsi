package vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class CommentVO {
	private int com_no;
	private String com_writer;
	private String com_content;
	private int com_like;
	private int com_hate;
	private String re_com;
	private int com_type;
	private Timestamp com_regdate;
	private int com_bno;
}

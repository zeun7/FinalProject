package multi.com.finalproject.jukebox.model;

import lombok.Data;

@Data
public class KakaoReadyVO {
	
	private String cid;
	private String partner_order_id;
	private String partner_user_id;
	private String item_name;
	private int quantity;
	private int total_amount;
	private int tax_free_amount;
	private String approval_url;
	private String cancel_url;
	private String fail_url;
	
}
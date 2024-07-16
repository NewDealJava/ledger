package com.newdeal.ledger.inquiry.dto;// package com.newdeal.ledger.inquiry.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
public class CommentDto {

    private int qcno;
    private String email;
    private int qbno;
    private String name;
    private Timestamp qcdate;
    private String q_ccontent;

}//CommentDto

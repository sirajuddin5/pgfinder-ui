package com.thryve.pgfinder_ui.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PageRequestDTO {

    private Integer pageNumber = 0;
    private Integer pageSize = 10;
    private String sort = "ASC";
    private String sortByColumn = "id";

}

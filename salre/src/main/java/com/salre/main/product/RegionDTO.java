package com.salre.main.product;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder 
@Getter
@Setter
public class RegionDTO {
	 int region_id;
	 String province;
	 float longitude;
	 float latitude;
}

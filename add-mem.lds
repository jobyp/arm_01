SECTIONS {
	 . = 0x00000000;
	 .text : { * (.text); }
	 
	 flash_sdata = .;

	 . = 0xA0000000;

	 ram_sdata = .;
	 
	 .data : AT (flash_sdata) { * (.data); }

	 ram_edata = .;
	 data_size = ram_sdata - ram_edata;
}
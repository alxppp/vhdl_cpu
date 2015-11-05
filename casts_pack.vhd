package casts_pack is

	function bit2boolean(b : bit) return boolean;

end casts_pack;

package body casts_pack is

	function bit2boolean(b : bit) return boolean is
	begin 
		return (b = '1');
	end bit2boolean;

end casts_pack;

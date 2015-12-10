package cpu_subprogram_pack is

    function reduce_or(data : bit_vector) return bit;
    function reduce_and(data : bit_vector) return bit;
    function reduce_xor(data : bit_vector) return bit;

end cpu_subprogram_pack;




package body cpu_subprogram_pack is

    function reduce_or(data : bit_vector) return bit is
    
    begin
    
        if data'length = 1 then
            return data(data'low);
        elsif data'length = 2 then
            return data(data'low) or data(data'high);
        else
            return reduce_or(data((data'high + data'low)/2 downto data'low)) or reduce_or(data(data'high downto (data'high+data'low)/2+1)); 
        end if;
    
    end reduce_or;

    function reduce_and(data : bit_vector) return bit is
    
    begin
     
         if data'length = 1 then
             return data(data'low);
         elsif data'length = 2 then
             return data(data'low) and data(data'high);
         else
             return reduce_and(data((data'high + data'low)/2 downto data'low)) and reduce_and(data(data'high downto (data'high+data'low)/2+1)); 
         end if;
     
    end reduce_and;
    
    function reduce_xor(data : bit_vector) return bit is
   
     begin
     
         if data'length = 1 then
             return data(data'low);
         elsif data'length = 2 then
             return data(data'low) xor data(data'high);
         else
             return reduce_xor(data((data'high + data'low)/2 downto data'low)) xor reduce_xor(data(data'high downto (data'high+data'low)/2+1)); 
         end if;
     
    
    end reduce_xor;

end cpu_subprogram_pack;
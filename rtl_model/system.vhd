library IEEE;
use IEEE.numeric_bit.all;

use WORK.cpu_defs_pack.all;
use WORK.cpu_subprogram_pack.all;

entity system is

    port (
        RST, CLK: in bit;
        ACTIVE: in bit;
        IN_DEV_RDY:   out bit;
        IN_DATA_REQ:  out bit;
        IN_DATA_OUT:  out bit_vector(11 downto 0));
        OUT_DEV_RDY:  out bit;
        OUT_DATA_RDY: out bit;
        OUT_DATA_OUT: out bit_vector(11 downto 0)
    );
end system;

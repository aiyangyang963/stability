-- ------------------------------------------------------------------------- 
-- High Level Design Compiler for Intel(R) FPGAs Version 17.0 (Release Build #595)
-- Quartus Prime development tool and MATLAB/Simulink Interface
-- 
-- Legal Notice: Copyright 2017 Intel Corporation.  All rights reserved.
-- Your use of  Intel Corporation's design tools,  logic functions and other
-- software and  tools, and its AMPP partner logic functions, and any output
-- files any  of the foregoing (including  device programming  or simulation
-- files), and  any associated  documentation  or information  are expressly
-- subject  to the terms and  conditions of the  Intel FPGA Software License
-- Agreement, Intel MegaCore Function License Agreement, or other applicable
-- license agreement,  including,  without limitation,  that your use is for
-- the  sole  purpose of  programming  logic devices  manufactured by  Intel
-- and  sold by Intel  or its authorized  distributors. Please refer  to the
-- applicable agreement for further details.
-- ---------------------------------------------------------------------------

-- VHDL created from fir_2_10hz_nco_rtl_core
-- VHDL created on Thu Jul 06 09:20:38 2017


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;
use std.TextIO.all;
use work.dspba_library_package.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY altera_lnsim;
USE altera_lnsim.altera_lnsim_components.altera_syncram;
LIBRARY lpm;
USE lpm.lpm_components.all;

entity fir_2_10hz_nco_rtl_core is
    port (
        xIn_v : in std_logic_vector(0 downto 0);  -- sfix1
        xIn_c : in std_logic_vector(7 downto 0);  -- sfix8
        xIn_0 : in std_logic_vector(12 downto 0);  -- sfix13
        xOut_v : out std_logic_vector(0 downto 0);  -- ufix1
        xOut_c : out std_logic_vector(7 downto 0);  -- ufix8
        xOut_0 : out std_logic_vector(54 downto 0);  -- sfix55
        clk : in std_logic;
        areset : in std_logic
    );
end fir_2_10hz_nco_rtl_core;

architecture normal of fir_2_10hz_nco_rtl_core is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_in0_m0_wi0_wo0_assign_id1_q_15_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_count : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_run_preEnaQ : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_out : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_enableQ : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_ctrl : STD_LOGIC_VECTOR (2 downto 0);
    signal u0_m0_wo0_memread_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_memread_q_13_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_memread_q_14_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_compute_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_compute_q_17_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_compute_q_18_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_count0_inner_q : STD_LOGIC_VECTOR (10 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_count0_inner_i : SIGNED (10 downto 0);
    attribute preserve : boolean;
    attribute preserve of u0_m0_wo0_wi0_r0_ra0_count0_inner_i : signal is true;
    signal u0_m0_wo0_wi0_r0_ra0_count0_q : STD_LOGIC_VECTOR (10 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_count0_i : UNSIGNED (9 downto 0);
    attribute preserve of u0_m0_wo0_wi0_r0_ra0_count0_i : signal is true;
    signal u0_m0_wo0_wi0_r0_ra0_count1_q : STD_LOGIC_VECTOR (9 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_count1_i : UNSIGNED (9 downto 0);
    attribute preserve of u0_m0_wo0_wi0_r0_ra0_count1_i : signal is true;
    signal u0_m0_wo0_wi0_r0_ra0_count1_eq : std_logic;
    attribute preserve of u0_m0_wo0_wi0_r0_ra0_count1_eq : signal is true;
    signal u0_m0_wo0_wi0_r0_ra0_add_0_0_a : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_add_0_0_b : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_add_0_0_o : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_add_0_0_q : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_wi0_r0_wa0_q : STD_LOGIC_VECTOR (9 downto 0);
    signal u0_m0_wo0_wi0_r0_wa0_i : UNSIGNED (9 downto 0);
    attribute preserve of u0_m0_wo0_wi0_r0_wa0_i : signal is true;
    signal u0_m0_wo0_wi0_r0_memr0_reset0 : std_logic;
    signal u0_m0_wo0_wi0_r0_memr0_ia : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_memr0_aa : STD_LOGIC_VECTOR (9 downto 0);
    signal u0_m0_wo0_wi0_r0_memr0_ab : STD_LOGIC_VECTOR (9 downto 0);
    signal u0_m0_wo0_wi0_r0_memr0_iq : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_memr0_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_ca0_q : STD_LOGIC_VECTOR (9 downto 0);
    signal u0_m0_wo0_ca0_i : UNSIGNED (9 downto 0);
    attribute preserve of u0_m0_wo0_ca0_i : signal is true;
    signal u0_m0_wo0_ca0_eq : std_logic;
    attribute preserve of u0_m0_wo0_ca0_eq : signal is true;
    signal u0_m0_wo0_aseq_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_aseq_eq : std_logic;
    signal u0_m0_wo0_accum_a : STD_LOGIC_VECTOR (54 downto 0);
    signal u0_m0_wo0_accum_b : STD_LOGIC_VECTOR (54 downto 0);
    signal u0_m0_wo0_accum_i : STD_LOGIC_VECTOR (54 downto 0);
    signal u0_m0_wo0_accum_o : STD_LOGIC_VECTOR (54 downto 0);
    signal u0_m0_wo0_accum_q : STD_LOGIC_VECTOR (54 downto 0);
    signal u0_m0_wo0_oseq_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_oseq_eq : std_logic;
    signal u0_m0_wo0_oseq_gated_reg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_count1_lut_lutmem_reset0 : std_logic;
    signal u0_m0_wo0_wi0_r0_ra0_count1_lut_lutmem_ia : STD_LOGIC_VECTOR (10 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_count1_lut_lutmem_aa : STD_LOGIC_VECTOR (9 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_count1_lut_lutmem_ab : STD_LOGIC_VECTOR (9 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_count1_lut_lutmem_ir : STD_LOGIC_VECTOR (10 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_count1_lut_lutmem_r : STD_LOGIC_VECTOR (10 downto 0);
    signal u0_m0_wo0_cm0_lutmem_reset0 : std_logic;
    signal u0_m0_wo0_cm0_lutmem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal u0_m0_wo0_cm0_lutmem_aa : STD_LOGIC_VECTOR (9 downto 0);
    signal u0_m0_wo0_cm0_lutmem_ab : STD_LOGIC_VECTOR (9 downto 0);
    signal u0_m0_wo0_cm0_lutmem_ir : STD_LOGIC_VECTOR (31 downto 0);
    signal u0_m0_wo0_cm0_lutmem_r : STD_LOGIC_VECTOR (31 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_result_add_0_0_a : STD_LOGIC_VECTOR (45 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_result_add_0_0_b : STD_LOGIC_VECTOR (45 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_result_add_0_0_o : STD_LOGIC_VECTOR (45 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_result_add_0_0_q : STD_LOGIC_VECTOR (45 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_im0_cma_reset : std_logic;
    type u0_m0_wo0_mtree_mult1_0_im0_cma_a0type is array(NATURAL range <>) of UNSIGNED(17 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_im0_cma_a0 : u0_m0_wo0_mtree_mult1_0_im0_cma_a0type(0 to 0);
    attribute preserve of u0_m0_wo0_mtree_mult1_0_im0_cma_a0 : signal is true;
    type u0_m0_wo0_mtree_mult1_0_im0_cma_c0type is array(NATURAL range <>) of SIGNED(12 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_im0_cma_c0 : u0_m0_wo0_mtree_mult1_0_im0_cma_c0type(0 to 0);
    attribute preserve of u0_m0_wo0_mtree_mult1_0_im0_cma_c0 : signal is true;
    type u0_m0_wo0_mtree_mult1_0_im0_cma_ltype is array(NATURAL range <>) of SIGNED(18 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_im0_cma_l : u0_m0_wo0_mtree_mult1_0_im0_cma_ltype(0 to 0);
    type u0_m0_wo0_mtree_mult1_0_im0_cma_ptype is array(NATURAL range <>) of SIGNED(31 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_im0_cma_p : u0_m0_wo0_mtree_mult1_0_im0_cma_ptype(0 to 0);
    signal u0_m0_wo0_mtree_mult1_0_im0_cma_u : u0_m0_wo0_mtree_mult1_0_im0_cma_ptype(0 to 0);
    signal u0_m0_wo0_mtree_mult1_0_im0_cma_w : u0_m0_wo0_mtree_mult1_0_im0_cma_ptype(0 to 0);
    signal u0_m0_wo0_mtree_mult1_0_im0_cma_x : u0_m0_wo0_mtree_mult1_0_im0_cma_ptype(0 to 0);
    signal u0_m0_wo0_mtree_mult1_0_im0_cma_y : u0_m0_wo0_mtree_mult1_0_im0_cma_ptype(0 to 0);
    signal u0_m0_wo0_mtree_mult1_0_im0_cma_s : u0_m0_wo0_mtree_mult1_0_im0_cma_ptype(0 to 0);
    signal u0_m0_wo0_mtree_mult1_0_im0_cma_qq : STD_LOGIC_VECTOR (30 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_im0_cma_q : STD_LOGIC_VECTOR (30 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_im0_cma_ena0 : std_logic;
    signal u0_m0_wo0_mtree_mult1_0_im0_cma_ena1 : std_logic;
    signal u0_m0_wo0_mtree_mult1_0_im3_cma_reset : std_logic;
    type u0_m0_wo0_mtree_mult1_0_im3_cma_a0type is array(NATURAL range <>) of SIGNED(13 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_im3_cma_a0 : u0_m0_wo0_mtree_mult1_0_im3_cma_a0type(0 to 0);
    attribute preserve of u0_m0_wo0_mtree_mult1_0_im3_cma_a0 : signal is true;
    signal u0_m0_wo0_mtree_mult1_0_im3_cma_c0 : u0_m0_wo0_mtree_mult1_0_im0_cma_c0type(0 to 0);
    attribute preserve of u0_m0_wo0_mtree_mult1_0_im3_cma_c0 : signal is true;
    type u0_m0_wo0_mtree_mult1_0_im3_cma_ptype is array(NATURAL range <>) of SIGNED(26 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_im3_cma_p : u0_m0_wo0_mtree_mult1_0_im3_cma_ptype(0 to 0);
    signal u0_m0_wo0_mtree_mult1_0_im3_cma_u : u0_m0_wo0_mtree_mult1_0_im3_cma_ptype(0 to 0);
    signal u0_m0_wo0_mtree_mult1_0_im3_cma_w : u0_m0_wo0_mtree_mult1_0_im3_cma_ptype(0 to 0);
    signal u0_m0_wo0_mtree_mult1_0_im3_cma_x : u0_m0_wo0_mtree_mult1_0_im3_cma_ptype(0 to 0);
    signal u0_m0_wo0_mtree_mult1_0_im3_cma_y : u0_m0_wo0_mtree_mult1_0_im3_cma_ptype(0 to 0);
    signal u0_m0_wo0_mtree_mult1_0_im3_cma_s : u0_m0_wo0_mtree_mult1_0_im3_cma_ptype(0 to 0);
    signal u0_m0_wo0_mtree_mult1_0_im3_cma_qq : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_im3_cma_q : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_im3_cma_ena0 : std_logic;
    signal u0_m0_wo0_mtree_mult1_0_im3_cma_ena1 : std_logic;
    signal d_xIn_0_15_mem_reset0 : std_logic;
    signal d_xIn_0_15_mem_ia : STD_LOGIC_VECTOR (12 downto 0);
    signal d_xIn_0_15_mem_aa : STD_LOGIC_VECTOR (1 downto 0);
    signal d_xIn_0_15_mem_ab : STD_LOGIC_VECTOR (1 downto 0);
    signal d_xIn_0_15_mem_iq : STD_LOGIC_VECTOR (12 downto 0);
    signal d_xIn_0_15_mem_q : STD_LOGIC_VECTOR (12 downto 0);
    signal d_xIn_0_15_rdcnt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal d_xIn_0_15_rdcnt_i : UNSIGNED (1 downto 0);
    attribute preserve of d_xIn_0_15_rdcnt_i : signal is true;
    signal d_xIn_0_15_wraddr_q : STD_LOGIC_VECTOR (1 downto 0);
    signal d_xIn_0_15_mem_last_q : STD_LOGIC_VECTOR (2 downto 0);
    signal d_xIn_0_15_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_xIn_0_15_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve of d_xIn_0_15_sticky_ena_q : signal is true;
    signal u0_m0_wo0_wi0_r0_ra0_count0_run_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_oseq_gated_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_xIn_0_15_cmp_b : STD_LOGIC_VECTOR (2 downto 0);
    signal d_xIn_0_15_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_xIn_0_15_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_xIn_0_15_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_xIn_0_15_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_resize_in : STD_LOGIC_VECTOR (9 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_resize_b : STD_LOGIC_VECTOR (9 downto 0);
    signal out0_m0_wo0_lineup_select_delay_0_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_bs1_in : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_bs1_b : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_bs4_b : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_align_7_q : STD_LOGIC_VECTOR (44 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_align_7_qint : STD_LOGIC_VECTOR (44 downto 0);
    signal out0_m0_wo0_assign_id3_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- VCC(CONSTANT,1)@0
    VCC_q <= "1";

    -- u0_m0_wo0_run(ENABLEGENERATOR,13)@10 + 2
    u0_m0_wo0_run_ctrl <= u0_m0_wo0_run_out & xIn_v & u0_m0_wo0_run_enableQ;
    u0_m0_wo0_run_clkproc: PROCESS (clk, areset)
        variable u0_m0_wo0_run_enable_c : SIGNED(10 downto 0);
        variable u0_m0_wo0_run_inc : SIGNED(1 downto 0);
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_run_q <= "0";
            u0_m0_wo0_run_enable_c := TO_SIGNED(632, 11);
            u0_m0_wo0_run_enableQ <= "0";
            u0_m0_wo0_run_count <= "00";
            u0_m0_wo0_run_inc := (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_run_out = "1") THEN
                IF (u0_m0_wo0_run_enable_c(10) = '1') THEN
                    u0_m0_wo0_run_enable_c := u0_m0_wo0_run_enable_c - (-633);
                ELSE
                    u0_m0_wo0_run_enable_c := u0_m0_wo0_run_enable_c + (-1);
                END IF;
                u0_m0_wo0_run_enableQ <= STD_LOGIC_VECTOR(u0_m0_wo0_run_enable_c(10 downto 10));
            ELSE
                u0_m0_wo0_run_enableQ <= "0";
            END IF;
            CASE (u0_m0_wo0_run_ctrl) IS
                WHEN "000" | "001" => u0_m0_wo0_run_inc := "00";
                WHEN "010" | "011" => u0_m0_wo0_run_inc := "11";
                WHEN "100" => u0_m0_wo0_run_inc := "00";
                WHEN "101" => u0_m0_wo0_run_inc := "01";
                WHEN "110" => u0_m0_wo0_run_inc := "11";
                WHEN "111" => u0_m0_wo0_run_inc := "00";
                WHEN OTHERS => 
            END CASE;
            u0_m0_wo0_run_count <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_run_count) + SIGNED(u0_m0_wo0_run_inc));
            u0_m0_wo0_run_q <= u0_m0_wo0_run_out;
        END IF;
    END PROCESS;
    u0_m0_wo0_run_preEnaQ <= u0_m0_wo0_run_count(1 downto 1);
    u0_m0_wo0_run_out <= u0_m0_wo0_run_preEnaQ and VCC_q;

    -- u0_m0_wo0_memread(DELAY,14)@12
    u0_m0_wo0_memread : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_run_q, xout => u0_m0_wo0_memread_q, clk => clk, aclr => areset );

    -- d_u0_m0_wo0_memread_q_13(DELAY,60)@12 + 1
    d_u0_m0_wo0_memread_q_13 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_memread_q, xout => d_u0_m0_wo0_memread_q_13_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_compute(DELAY,16)@13
    u0_m0_wo0_compute : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => d_u0_m0_wo0_memread_q_13_q, xout => u0_m0_wo0_compute_q, clk => clk, aclr => areset );

    -- d_u0_m0_wo0_compute_q_17(DELAY,62)@13 + 4
    d_u0_m0_wo0_compute_q_17 : dspba_delay
    GENERIC MAP ( width => 1, depth => 4, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_compute_q, xout => d_u0_m0_wo0_compute_q_17_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_aseq(SEQUENCE,34)@17 + 1
    u0_m0_wo0_aseq_clkproc: PROCESS (clk, areset)
        variable u0_m0_wo0_aseq_c : SIGNED(11 downto 0);
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_aseq_c := "000000000000";
            u0_m0_wo0_aseq_q <= "0";
            u0_m0_wo0_aseq_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_17_q = "1") THEN
                IF (u0_m0_wo0_aseq_c = "000000000000") THEN
                    u0_m0_wo0_aseq_eq <= '1';
                ELSE
                    u0_m0_wo0_aseq_eq <= '0';
                END IF;
                IF (u0_m0_wo0_aseq_eq = '1') THEN
                    u0_m0_wo0_aseq_c := u0_m0_wo0_aseq_c + 633;
                ELSE
                    u0_m0_wo0_aseq_c := u0_m0_wo0_aseq_c - 1;
                END IF;
                u0_m0_wo0_aseq_q <= STD_LOGIC_VECTOR(u0_m0_wo0_aseq_c(11 downto 11));
            END IF;
        END IF;
    END PROCESS;

    -- d_u0_m0_wo0_compute_q_18(DELAY,63)@17 + 1
    d_u0_m0_wo0_compute_q_18 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => d_u0_m0_wo0_compute_q_17_q, xout => d_u0_m0_wo0_compute_q_18_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_ra0_count1(COUNTER,23)@12
    -- low=0, high=633, step=1, init=0
    u0_m0_wo0_wi0_r0_ra0_count1_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_ra0_count1_i <= TO_UNSIGNED(0, 10);
            u0_m0_wo0_wi0_r0_ra0_count1_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_memread_q = "1") THEN
                IF (u0_m0_wo0_wi0_r0_ra0_count1_i = TO_UNSIGNED(632, 10)) THEN
                    u0_m0_wo0_wi0_r0_ra0_count1_eq <= '1';
                ELSE
                    u0_m0_wo0_wi0_r0_ra0_count1_eq <= '0';
                END IF;
                IF (u0_m0_wo0_wi0_r0_ra0_count1_eq = '1') THEN
                    u0_m0_wo0_wi0_r0_ra0_count1_i <= u0_m0_wo0_wi0_r0_ra0_count1_i + 391;
                ELSE
                    u0_m0_wo0_wi0_r0_ra0_count1_i <= u0_m0_wo0_wi0_r0_ra0_count1_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_ra0_count1_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_r0_ra0_count1_i, 10)));

    -- u0_m0_wo0_wi0_r0_ra0_count1_lut_lutmem(DUALMEM,44)@12 + 2
    u0_m0_wo0_wi0_r0_ra0_count1_lut_lutmem_aa <= u0_m0_wo0_wi0_r0_ra0_count1_q;
    u0_m0_wo0_wi0_r0_ra0_count1_lut_lutmem_reset0 <= areset;
    u0_m0_wo0_wi0_r0_ra0_count1_lut_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M10K",
        operation_mode => "ROM",
        width_a => 11,
        widthad_a => 10,
        numwords_a => 634,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_aclr_a => "CLEAR0",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => "fir_2_10hz_nco_rtl_core_u0_m0_wo0_wi0_r0_ra0_count1_lut_lutmem.hex",
        init_file_layout => "PORT_A",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken0 => VCC_q(0),
        aclr0 => u0_m0_wo0_wi0_r0_ra0_count1_lut_lutmem_reset0,
        clock0 => clk,
        address_a => u0_m0_wo0_wi0_r0_ra0_count1_lut_lutmem_aa,
        q_a => u0_m0_wo0_wi0_r0_ra0_count1_lut_lutmem_ir
    );
    u0_m0_wo0_wi0_r0_ra0_count1_lut_lutmem_r <= u0_m0_wo0_wi0_r0_ra0_count1_lut_lutmem_ir(10 downto 0);

    -- u0_m0_wo0_wi0_r0_ra0_count0_inner(COUNTER,19)@14
    -- low=-1, high=632, step=-1, init=632
    u0_m0_wo0_wi0_r0_ra0_count0_inner_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_ra0_count0_inner_i <= TO_SIGNED(632, 11);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_memread_q_14_q = "1") THEN
                IF (u0_m0_wo0_wi0_r0_ra0_count0_inner_i(10 downto 10) = "1") THEN
                    u0_m0_wo0_wi0_r0_ra0_count0_inner_i <= u0_m0_wo0_wi0_r0_ra0_count0_inner_i - 1415;
                ELSE
                    u0_m0_wo0_wi0_r0_ra0_count0_inner_i <= u0_m0_wo0_wi0_r0_ra0_count0_inner_i - 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_ra0_count0_inner_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_r0_ra0_count0_inner_i, 11)));

    -- u0_m0_wo0_wi0_r0_ra0_count0_run(LOGICAL,20)@14
    u0_m0_wo0_wi0_r0_ra0_count0_run_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_ra0_count0_inner_q(10 downto 10));

    -- d_u0_m0_wo0_memread_q_14(DELAY,61)@13 + 1
    d_u0_m0_wo0_memread_q_14 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => d_u0_m0_wo0_memread_q_13_q, xout => d_u0_m0_wo0_memread_q_14_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_ra0_count0(COUNTER,21)@14
    -- low=0, high=1023, step=1, init=0
    u0_m0_wo0_wi0_r0_ra0_count0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_ra0_count0_i <= TO_UNSIGNED(0, 10);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_memread_q_14_q = "1" and u0_m0_wo0_wi0_r0_ra0_count0_run_q = "1") THEN
                u0_m0_wo0_wi0_r0_ra0_count0_i <= u0_m0_wo0_wi0_r0_ra0_count0_i + 1;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_ra0_count0_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_r0_ra0_count0_i, 11)));

    -- u0_m0_wo0_wi0_r0_ra0_add_0_0(ADD,24)@14 + 1
    u0_m0_wo0_wi0_r0_ra0_add_0_0_a <= STD_LOGIC_VECTOR("0" & u0_m0_wo0_wi0_r0_ra0_count0_q);
    u0_m0_wo0_wi0_r0_ra0_add_0_0_b <= STD_LOGIC_VECTOR("0" & u0_m0_wo0_wi0_r0_ra0_count1_lut_lutmem_r);
    u0_m0_wo0_wi0_r0_ra0_add_0_0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_ra0_add_0_0_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_wi0_r0_ra0_add_0_0_o <= STD_LOGIC_VECTOR(UNSIGNED(u0_m0_wo0_wi0_r0_ra0_add_0_0_a) + UNSIGNED(u0_m0_wo0_wi0_r0_ra0_add_0_0_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_ra0_add_0_0_q <= u0_m0_wo0_wi0_r0_ra0_add_0_0_o(11 downto 0);

    -- u0_m0_wo0_wi0_r0_ra0_resize(BITSELECT,25)@15
    u0_m0_wo0_wi0_r0_ra0_resize_in <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_ra0_add_0_0_q(9 downto 0));
    u0_m0_wo0_wi0_r0_ra0_resize_b <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_ra0_resize_in(9 downto 0));

    -- d_xIn_0_15_notEnable(LOGICAL,70)@10
    d_xIn_0_15_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- d_xIn_0_15_nor(LOGICAL,71)@10
    d_xIn_0_15_nor_q <= not (d_xIn_0_15_notEnable_q or d_xIn_0_15_sticky_ena_q);

    -- d_xIn_0_15_mem_last(CONSTANT,67)
    d_xIn_0_15_mem_last_q <= "010";

    -- d_xIn_0_15_cmp(LOGICAL,68)@10
    d_xIn_0_15_cmp_b <= STD_LOGIC_VECTOR("0" & d_xIn_0_15_rdcnt_q);
    d_xIn_0_15_cmp_q <= "1" WHEN d_xIn_0_15_mem_last_q = d_xIn_0_15_cmp_b ELSE "0";

    -- d_xIn_0_15_cmpReg(REG,69)@10 + 1
    d_xIn_0_15_cmpReg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            d_xIn_0_15_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            d_xIn_0_15_cmpReg_q <= STD_LOGIC_VECTOR(d_xIn_0_15_cmp_q);
        END IF;
    END PROCESS;

    -- d_xIn_0_15_sticky_ena(REG,72)@10 + 1
    d_xIn_0_15_sticky_ena_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            d_xIn_0_15_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_xIn_0_15_nor_q = "1") THEN
                d_xIn_0_15_sticky_ena_q <= STD_LOGIC_VECTOR(d_xIn_0_15_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- d_xIn_0_15_enaAnd(LOGICAL,73)@10
    d_xIn_0_15_enaAnd_q <= d_xIn_0_15_sticky_ena_q and VCC_q;

    -- d_xIn_0_15_rdcnt(COUNTER,65)@10 + 1
    -- low=0, high=3, step=1, init=0
    d_xIn_0_15_rdcnt_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            d_xIn_0_15_rdcnt_i <= TO_UNSIGNED(0, 2);
        ELSIF (clk'EVENT AND clk = '1') THEN
            d_xIn_0_15_rdcnt_i <= d_xIn_0_15_rdcnt_i + 1;
        END IF;
    END PROCESS;
    d_xIn_0_15_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(d_xIn_0_15_rdcnt_i, 2)));

    -- d_xIn_0_15_wraddr(REG,66)@10 + 1
    d_xIn_0_15_wraddr_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            d_xIn_0_15_wraddr_q <= "11";
        ELSIF (clk'EVENT AND clk = '1') THEN
            d_xIn_0_15_wraddr_q <= STD_LOGIC_VECTOR(d_xIn_0_15_rdcnt_q);
        END IF;
    END PROCESS;

    -- d_xIn_0_15_mem(DUALMEM,64)@10 + 2
    d_xIn_0_15_mem_ia <= STD_LOGIC_VECTOR(xIn_0);
    d_xIn_0_15_mem_aa <= d_xIn_0_15_wraddr_q;
    d_xIn_0_15_mem_ab <= d_xIn_0_15_rdcnt_q;
    d_xIn_0_15_mem_reset0 <= areset;
    d_xIn_0_15_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 13,
        widthad_a => 2,
        numwords_a => 4,
        width_b => 13,
        widthad_b => 2,
        numwords_b => 4,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_aclr_b => "CLEAR1",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken1 => d_xIn_0_15_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clk,
        aclr1 => d_xIn_0_15_mem_reset0,
        clock1 => clk,
        address_a => d_xIn_0_15_mem_aa,
        data_a => d_xIn_0_15_mem_ia,
        wren_a => VCC_q(0),
        address_b => d_xIn_0_15_mem_ab,
        q_b => d_xIn_0_15_mem_iq
    );
    d_xIn_0_15_mem_q <= d_xIn_0_15_mem_iq(12 downto 0);

    -- d_in0_m0_wi0_wo0_assign_id1_q_15(DELAY,59)@10 + 5
    d_in0_m0_wi0_wo0_assign_id1_q_15 : dspba_delay
    GENERIC MAP ( width => 1, depth => 5, reset_kind => "ASYNC" )
    PORT MAP ( xin => xIn_v, xout => d_in0_m0_wi0_wo0_assign_id1_q_15_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_wa0(COUNTER,26)@15
    -- low=0, high=1023, step=1, init=243
    u0_m0_wo0_wi0_r0_wa0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_wa0_i <= TO_UNSIGNED(243, 10);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_in0_m0_wi0_wo0_assign_id1_q_15_q = "1") THEN
                u0_m0_wo0_wi0_r0_wa0_i <= u0_m0_wo0_wi0_r0_wa0_i + 1;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_wa0_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_r0_wa0_i, 10)));

    -- u0_m0_wo0_wi0_r0_memr0(DUALMEM,27)@15
    u0_m0_wo0_wi0_r0_memr0_ia <= STD_LOGIC_VECTOR(d_xIn_0_15_mem_q);
    u0_m0_wo0_wi0_r0_memr0_aa <= u0_m0_wo0_wi0_r0_wa0_q;
    u0_m0_wo0_wi0_r0_memr0_ab <= u0_m0_wo0_wi0_r0_ra0_resize_b;
    u0_m0_wo0_wi0_r0_memr0_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M10K",
        operation_mode => "DUAL_PORT",
        width_a => 13,
        widthad_a => 10,
        numwords_a => 1024,
        width_b => 13,
        widthad_b => 10,
        numwords_b => 1024,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_aclr_b => "NONE",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken0 => '1',
        clock0 => clk,
        address_a => u0_m0_wo0_wi0_r0_memr0_aa,
        data_a => u0_m0_wo0_wi0_r0_memr0_ia,
        wren_a => d_in0_m0_wi0_wo0_assign_id1_q_15_q(0),
        address_b => u0_m0_wo0_wi0_r0_memr0_ab,
        q_b => u0_m0_wo0_wi0_r0_memr0_iq
    );
    u0_m0_wo0_wi0_r0_memr0_q <= u0_m0_wo0_wi0_r0_memr0_iq(12 downto 0);

    -- u0_m0_wo0_ca0(COUNTER,28)@13
    -- low=0, high=633, step=1, init=0
    u0_m0_wo0_ca0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_ca0_i <= TO_UNSIGNED(0, 10);
            u0_m0_wo0_ca0_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_compute_q = "1") THEN
                IF (u0_m0_wo0_ca0_i = TO_UNSIGNED(632, 10)) THEN
                    u0_m0_wo0_ca0_eq <= '1';
                ELSE
                    u0_m0_wo0_ca0_eq <= '0';
                END IF;
                IF (u0_m0_wo0_ca0_eq = '1') THEN
                    u0_m0_wo0_ca0_i <= u0_m0_wo0_ca0_i + 391;
                ELSE
                    u0_m0_wo0_ca0_i <= u0_m0_wo0_ca0_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_ca0_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_ca0_i, 10)));

    -- u0_m0_wo0_cm0_lutmem(DUALMEM,45)@13 + 2
    u0_m0_wo0_cm0_lutmem_aa <= u0_m0_wo0_ca0_q;
    u0_m0_wo0_cm0_lutmem_reset0 <= areset;
    u0_m0_wo0_cm0_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M10K",
        operation_mode => "ROM",
        width_a => 32,
        widthad_a => 10,
        numwords_a => 634,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_aclr_a => "CLEAR0",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => "fir_2_10hz_nco_rtl_core_u0_m0_wo0_cm0_lutmem.hex",
        init_file_layout => "PORT_A",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken0 => '1',
        aclr0 => u0_m0_wo0_cm0_lutmem_reset0,
        clock0 => clk,
        address_a => u0_m0_wo0_cm0_lutmem_aa,
        q_a => u0_m0_wo0_cm0_lutmem_ir
    );
    u0_m0_wo0_cm0_lutmem_r <= u0_m0_wo0_cm0_lutmem_ir(31 downto 0);

    -- u0_m0_wo0_mtree_mult1_0_bs4(BITSELECT,50)@15
    u0_m0_wo0_mtree_mult1_0_bs4_b <= STD_LOGIC_VECTOR(u0_m0_wo0_cm0_lutmem_r(31 downto 18));

    -- u0_m0_wo0_mtree_mult1_0_im3_cma(CHAINMULTADD,57)@15 + 2
    u0_m0_wo0_mtree_mult1_0_im3_cma_reset <= areset;
    u0_m0_wo0_mtree_mult1_0_im3_cma_ena0 <= '1';
    u0_m0_wo0_mtree_mult1_0_im3_cma_ena1 <= u0_m0_wo0_mtree_mult1_0_im3_cma_ena0;
    u0_m0_wo0_mtree_mult1_0_im3_cma_p(0) <= u0_m0_wo0_mtree_mult1_0_im3_cma_a0(0) * u0_m0_wo0_mtree_mult1_0_im3_cma_c0(0);
    u0_m0_wo0_mtree_mult1_0_im3_cma_u(0) <= RESIZE(u0_m0_wo0_mtree_mult1_0_im3_cma_p(0),27);
    u0_m0_wo0_mtree_mult1_0_im3_cma_w(0) <= u0_m0_wo0_mtree_mult1_0_im3_cma_u(0);
    u0_m0_wo0_mtree_mult1_0_im3_cma_x(0) <= u0_m0_wo0_mtree_mult1_0_im3_cma_w(0);
    u0_m0_wo0_mtree_mult1_0_im3_cma_y(0) <= u0_m0_wo0_mtree_mult1_0_im3_cma_x(0);
    u0_m0_wo0_mtree_mult1_0_im3_cma_chainmultadd_input: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_0_im3_cma_a0 <= (others => (others => '0'));
            u0_m0_wo0_mtree_mult1_0_im3_cma_c0 <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_mtree_mult1_0_im3_cma_ena0 = '1') THEN
                u0_m0_wo0_mtree_mult1_0_im3_cma_a0(0) <= RESIZE(SIGNED(u0_m0_wo0_mtree_mult1_0_bs4_b),14);
                u0_m0_wo0_mtree_mult1_0_im3_cma_c0(0) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_memr0_q),13);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_0_im3_cma_chainmultadd_output: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_0_im3_cma_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_mtree_mult1_0_im3_cma_ena1 = '1') THEN
                u0_m0_wo0_mtree_mult1_0_im3_cma_s(0) <= u0_m0_wo0_mtree_mult1_0_im3_cma_y(0);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_0_im3_cma_delay : dspba_delay
    GENERIC MAP ( width => 27, depth => 0, reset_kind => "ASYNC" )
    PORT MAP ( xin => STD_LOGIC_VECTOR(u0_m0_wo0_mtree_mult1_0_im3_cma_s(0)(26 downto 0)), xout => u0_m0_wo0_mtree_mult1_0_im3_cma_qq, clk => clk, aclr => areset );
    u0_m0_wo0_mtree_mult1_0_im3_cma_q <= STD_LOGIC_VECTOR(u0_m0_wo0_mtree_mult1_0_im3_cma_qq(26 downto 0));

    -- u0_m0_wo0_mtree_mult1_0_align_7(BITSHIFT,53)@17
    u0_m0_wo0_mtree_mult1_0_align_7_qint <= u0_m0_wo0_mtree_mult1_0_im3_cma_q & "000000000000000000";
    u0_m0_wo0_mtree_mult1_0_align_7_q <= u0_m0_wo0_mtree_mult1_0_align_7_qint(44 downto 0);

    -- u0_m0_wo0_mtree_mult1_0_bs1(BITSELECT,47)@15
    u0_m0_wo0_mtree_mult1_0_bs1_in <= u0_m0_wo0_cm0_lutmem_r(17 downto 0);
    u0_m0_wo0_mtree_mult1_0_bs1_b <= u0_m0_wo0_mtree_mult1_0_bs1_in(17 downto 0);

    -- u0_m0_wo0_mtree_mult1_0_im0_cma(CHAINMULTADD,56)@15 + 2
    u0_m0_wo0_mtree_mult1_0_im0_cma_reset <= areset;
    u0_m0_wo0_mtree_mult1_0_im0_cma_ena0 <= '1';
    u0_m0_wo0_mtree_mult1_0_im0_cma_ena1 <= u0_m0_wo0_mtree_mult1_0_im0_cma_ena0;
    u0_m0_wo0_mtree_mult1_0_im0_cma_l(0) <= SIGNED(RESIZE(u0_m0_wo0_mtree_mult1_0_im0_cma_a0(0),19));
    u0_m0_wo0_mtree_mult1_0_im0_cma_p(0) <= u0_m0_wo0_mtree_mult1_0_im0_cma_l(0) * u0_m0_wo0_mtree_mult1_0_im0_cma_c0(0);
    u0_m0_wo0_mtree_mult1_0_im0_cma_u(0) <= RESIZE(u0_m0_wo0_mtree_mult1_0_im0_cma_p(0),32);
    u0_m0_wo0_mtree_mult1_0_im0_cma_w(0) <= u0_m0_wo0_mtree_mult1_0_im0_cma_u(0);
    u0_m0_wo0_mtree_mult1_0_im0_cma_x(0) <= u0_m0_wo0_mtree_mult1_0_im0_cma_w(0);
    u0_m0_wo0_mtree_mult1_0_im0_cma_y(0) <= u0_m0_wo0_mtree_mult1_0_im0_cma_x(0);
    u0_m0_wo0_mtree_mult1_0_im0_cma_chainmultadd_input: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_0_im0_cma_a0 <= (others => (others => '0'));
            u0_m0_wo0_mtree_mult1_0_im0_cma_c0 <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_mtree_mult1_0_im0_cma_ena0 = '1') THEN
                u0_m0_wo0_mtree_mult1_0_im0_cma_a0(0) <= RESIZE(UNSIGNED(u0_m0_wo0_mtree_mult1_0_bs1_b),18);
                u0_m0_wo0_mtree_mult1_0_im0_cma_c0(0) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_memr0_q),13);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_0_im0_cma_chainmultadd_output: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_0_im0_cma_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_mtree_mult1_0_im0_cma_ena1 = '1') THEN
                u0_m0_wo0_mtree_mult1_0_im0_cma_s(0) <= u0_m0_wo0_mtree_mult1_0_im0_cma_y(0);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_0_im0_cma_delay : dspba_delay
    GENERIC MAP ( width => 31, depth => 0, reset_kind => "ASYNC" )
    PORT MAP ( xin => STD_LOGIC_VECTOR(u0_m0_wo0_mtree_mult1_0_im0_cma_s(0)(30 downto 0)), xout => u0_m0_wo0_mtree_mult1_0_im0_cma_qq, clk => clk, aclr => areset );
    u0_m0_wo0_mtree_mult1_0_im0_cma_q <= STD_LOGIC_VECTOR(u0_m0_wo0_mtree_mult1_0_im0_cma_qq(30 downto 0));

    -- u0_m0_wo0_mtree_mult1_0_result_add_0_0(ADD,55)@17 + 1
    u0_m0_wo0_mtree_mult1_0_result_add_0_0_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((45 downto 31 => u0_m0_wo0_mtree_mult1_0_im0_cma_q(30)) & u0_m0_wo0_mtree_mult1_0_im0_cma_q));
    u0_m0_wo0_mtree_mult1_0_result_add_0_0_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((45 downto 45 => u0_m0_wo0_mtree_mult1_0_align_7_q(44)) & u0_m0_wo0_mtree_mult1_0_align_7_q));
    u0_m0_wo0_mtree_mult1_0_result_add_0_0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_0_result_add_0_0_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_0_result_add_0_0_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_mult1_0_result_add_0_0_a) + SIGNED(u0_m0_wo0_mtree_mult1_0_result_add_0_0_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_0_result_add_0_0_q <= u0_m0_wo0_mtree_mult1_0_result_add_0_0_o(45 downto 0);

    -- u0_m0_wo0_accum(ADD,35)@18 + 1
    u0_m0_wo0_accum_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((54 downto 46 => u0_m0_wo0_mtree_mult1_0_result_add_0_0_q(45)) & u0_m0_wo0_mtree_mult1_0_result_add_0_0_q));
    u0_m0_wo0_accum_b <= STD_LOGIC_VECTOR(u0_m0_wo0_accum_q);
    u0_m0_wo0_accum_i <= u0_m0_wo0_accum_a;
    u0_m0_wo0_accum_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_accum_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_18_q = "1") THEN
                IF (u0_m0_wo0_aseq_q = "1") THEN
                    u0_m0_wo0_accum_o <= u0_m0_wo0_accum_i;
                ELSE
                    u0_m0_wo0_accum_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_accum_a) + SIGNED(u0_m0_wo0_accum_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_accum_q <= u0_m0_wo0_accum_o(54 downto 0);

    -- GND(CONSTANT,0)@0
    GND_q <= "0";

    -- u0_m0_wo0_oseq(SEQUENCE,36)@17 + 1
    u0_m0_wo0_oseq_clkproc: PROCESS (clk, areset)
        variable u0_m0_wo0_oseq_c : SIGNED(11 downto 0);
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_oseq_c := "001001111001";
            u0_m0_wo0_oseq_q <= "0";
            u0_m0_wo0_oseq_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_17_q = "1") THEN
                IF (u0_m0_wo0_oseq_c = "000000000000") THEN
                    u0_m0_wo0_oseq_eq <= '1';
                ELSE
                    u0_m0_wo0_oseq_eq <= '0';
                END IF;
                IF (u0_m0_wo0_oseq_eq = '1') THEN
                    u0_m0_wo0_oseq_c := u0_m0_wo0_oseq_c + 633;
                ELSE
                    u0_m0_wo0_oseq_c := u0_m0_wo0_oseq_c - 1;
                END IF;
                u0_m0_wo0_oseq_q <= STD_LOGIC_VECTOR(u0_m0_wo0_oseq_c(11 downto 11));
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_oseq_gated(LOGICAL,37)@18
    u0_m0_wo0_oseq_gated_q <= u0_m0_wo0_oseq_q and d_u0_m0_wo0_compute_q_18_q;

    -- u0_m0_wo0_oseq_gated_reg(REG,38)@18 + 1
    u0_m0_wo0_oseq_gated_reg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_oseq_gated_reg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_oseq_gated_reg_q <= STD_LOGIC_VECTOR(u0_m0_wo0_oseq_gated_q);
        END IF;
    END PROCESS;

    -- out0_m0_wo0_lineup_select_delay_0(DELAY,40)@19
    out0_m0_wo0_lineup_select_delay_0_q <= STD_LOGIC_VECTOR(u0_m0_wo0_oseq_gated_reg_q);

    -- out0_m0_wo0_assign_id3(DELAY,42)@19
    out0_m0_wo0_assign_id3_q <= STD_LOGIC_VECTOR(out0_m0_wo0_lineup_select_delay_0_q);

    -- xOut(PORTOUT,43)@19 + 1
    xOut_v <= out0_m0_wo0_assign_id3_q;
    xOut_c <= STD_LOGIC_VECTOR("0000000" & GND_q);
    xOut_0 <= u0_m0_wo0_accum_q;

END normal;

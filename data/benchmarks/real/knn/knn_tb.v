`timescale 1 ps / 1 ps

// Testbench for the new bd_0_wrapper module
module new_design_tb;

    // Parameters
    parameter CLK_PERIOD = 8000; // 8.0 ns clock period (125 MHz)

    // Control Signals
    reg  ap_clk;
    reg  ap_rst;
    reg  ap_ctrl_start;
    wire ap_ctrl_done;
    wire ap_ctrl_idle;
    wire ap_ctrl_ready;

    // ===================================================================
    // == 1. Signal Declarations for DUT Interface
    // ===================================================================
    
    // NL Interfaces (Read-Only)
    wire [4:0] NL_0_address0, NL_0_address1; wire NL_0_ce0, NL_0_ce1; reg [31:0] NL_0_q0, NL_0_q1;
    wire [4:0] NL_1_address0, NL_1_address1; wire NL_1_ce0, NL_1_ce1; reg [31:0] NL_1_q0, NL_1_q1;
    wire [4:0] NL_2_address0, NL_2_address1; wire NL_2_ce0, NL_2_ce1; reg [31:0] NL_2_q0, NL_2_q1;
    wire [4:0] NL_3_address0, NL_3_address1; wire NL_3_ce0, NL_3_ce1; reg [31:0] NL_3_q0, NL_3_q1;
    wire [4:0] NL_4_address0, NL_4_address1; wire NL_4_ce0, NL_4_ce1; reg [31:0] NL_4_q0, NL_4_q1;
    wire [4:0] NL_5_address0, NL_5_address1; wire NL_5_ce0, NL_5_ce1; reg [31:0] NL_5_q0, NL_5_q1;
    wire [4:0] NL_6_address0, NL_6_address1; wire NL_6_ce0, NL_6_ce1; reg [31:0] NL_6_q0, NL_6_q1;
    wire [4:0] NL_7_address0, NL_7_address1; wire NL_7_ce0, NL_7_ce1; reg [31:0] NL_7_q0, NL_7_q1;
    wire [4:0] NL_8_address0, NL_8_address1; wire NL_8_ce0, NL_8_ce1; reg [31:0] NL_8_q0, NL_8_q1;
    wire [4:0] NL_9_address0, NL_9_address1; wire NL_9_ce0, NL_9_ce1; reg [31:0] NL_9_q0, NL_9_q1;
    wire [4:0] NL_10_address0, NL_10_address1; wire NL_10_ce0, NL_10_ce1; reg [31:0] NL_10_q0, NL_10_q1;
    wire [4:0] NL_11_address0, NL_11_address1; wire NL_11_ce0, NL_11_ce1; reg [31:0] NL_11_q0, NL_11_q1;
    wire [4:0] NL_12_address0, NL_12_address1; wire NL_12_ce0, NL_12_ce1; reg [31:0] NL_12_q0, NL_12_q1;
    wire [4:0] NL_13_address0, NL_13_address1; wire NL_13_ce0, NL_13_ce1; reg [31:0] NL_13_q0, NL_13_q1;
    wire [4:0] NL_14_address0, NL_14_address1; wire NL_14_ce0, NL_14_ce1; reg [31:0] NL_14_q0, NL_14_q1;
    wire [4:0] NL_15_address0, NL_15_address1; wire NL_15_ce0, NL_15_ce1; reg [31:0] NL_15_q0, NL_15_q1;
    wire [4:0] NL_16_address0, NL_16_address1; wire NL_16_ce0, NL_16_ce1; reg [31:0] NL_16_q0, NL_16_q1;
    wire [4:0] NL_17_address0, NL_17_address1; wire NL_17_ce0, NL_17_ce1; reg [31:0] NL_17_q0, NL_17_q1;
    wire [4:0] NL_18_address0, NL_18_address1; wire NL_18_ce0, NL_18_ce1; reg [31:0] NL_18_q0, NL_18_q1;
    wire [4:0] NL_19_address0, NL_19_address1; wire NL_19_ce0, NL_19_ce1; reg [31:0] NL_19_q0, NL_19_q1;
    wire [4:0] NL_20_address0, NL_20_address1; wire NL_20_ce0, NL_20_ce1; reg [31:0] NL_20_q0, NL_20_q1;
    wire [4:0] NL_21_address0, NL_21_address1; wire NL_21_ce0, NL_21_ce1; reg [31:0] NL_21_q0, NL_21_q1;
    wire [4:0] NL_22_address0, NL_22_address1; wire NL_22_ce0, NL_22_ce1; reg [31:0] NL_22_q0, NL_22_q1;
    wire [4:0] NL_23_address0, NL_23_address1; wire NL_23_ce0, NL_23_ce1; reg [31:0] NL_23_q0, NL_23_q1;
    wire [4:0] NL_24_address0, NL_24_address1; wire NL_24_ce0, NL_24_ce1; reg [31:0] NL_24_q0, NL_24_q1;
    wire [4:0] NL_25_address0, NL_25_address1; wire NL_25_ce0, NL_25_ce1; reg [31:0] NL_25_q0, NL_25_q1;
    wire [4:0] NL_26_address0, NL_26_address1; wire NL_26_ce0, NL_26_ce1; reg [31:0] NL_26_q0, NL_26_q1;
    wire [4:0] NL_27_address0, NL_27_address1; wire NL_27_ce0, NL_27_ce1; reg [31:0] NL_27_q0, NL_27_q1;
    wire [4:0] NL_28_address0, NL_28_address1; wire NL_28_ce0, NL_28_ce1; reg [31:0] NL_28_q0, NL_28_q1;
    wire [4:0] NL_29_address0, NL_29_address1; wire NL_29_ce0, NL_29_ce1; reg [31:0] NL_29_q0, NL_29_q1;
    wire [4:0] NL_30_address0, NL_30_address1; wire NL_30_ce0, NL_30_ce1; reg [31:0] NL_30_q0, NL_30_q1;
    wire [4:0] NL_31_address0, NL_31_address1; wire NL_31_ce0, NL_31_ce1; reg [31:0] NL_31_q0, NL_31_q1;
    wire [4:0] NL_32_address0, NL_32_address1; wire NL_32_ce0, NL_32_ce1; reg [31:0] NL_32_q0, NL_32_q1;
    wire [4:0] NL_33_address0, NL_33_address1; wire NL_33_ce0, NL_33_ce1; reg [31:0] NL_33_q0, NL_33_q1;
    wire [4:0] NL_34_address0, NL_34_address1; wire NL_34_ce0, NL_34_ce1; reg [31:0] NL_34_q0, NL_34_q1;
    wire [4:0] NL_35_address0, NL_35_address1; wire NL_35_ce0, NL_35_ce1; reg [31:0] NL_35_q0, NL_35_q1;
    wire [4:0] NL_36_address0, NL_36_address1; wire NL_36_ce0, NL_36_ce1; reg [31:0] NL_36_q0, NL_36_q1;
    wire [4:0] NL_37_address0, NL_37_address1; wire NL_37_ce0, NL_37_ce1; reg [31:0] NL_37_q0, NL_37_q1;
    wire [4:0] NL_38_address0, NL_38_address1; wire NL_38_ce0, NL_38_ce1; reg [31:0] NL_38_q0, NL_38_q1;
    wire [4:0] NL_39_address0, NL_39_address1; wire NL_39_ce0, NL_39_ce1; reg [31:0] NL_39_q0, NL_39_q1;
    wire [4:0] NL_40_address0, NL_40_address1; wire NL_40_ce0, NL_40_ce1; reg [31:0] NL_40_q0, NL_40_q1;
    wire [4:0] NL_41_address0, NL_41_address1; wire NL_41_ce0, NL_41_ce1; reg [31:0] NL_41_q0, NL_41_q1;
    wire [4:0] NL_42_address0, NL_42_address1; wire NL_42_ce0, NL_42_ce1; reg [31:0] NL_42_q0, NL_42_q1;
    wire [4:0] NL_43_address0, NL_43_address1; wire NL_43_ce0, NL_43_ce1; reg [31:0] NL_43_q0, NL_43_q1;
    wire [4:0] NL_44_address0, NL_44_address1; wire NL_44_ce0, NL_44_ce1; reg [31:0] NL_44_q0, NL_44_q1;
    wire [4:0] NL_45_address0, NL_45_address1; wire NL_45_ce0, NL_45_ce1; reg [31:0] NL_45_q0, NL_45_q1;
    wire [4:0] NL_46_address0, NL_46_address1; wire NL_46_ce0, NL_46_ce1; reg [31:0] NL_46_q0, NL_46_q1;
    wire [4:0] NL_47_address0, NL_47_address1; wire NL_47_ce0, NL_47_ce1; reg [31:0] NL_47_q0, NL_47_q1;
    wire [4:0] NL_48_address0, NL_48_address1; wire NL_48_ce0, NL_48_ce1; reg [31:0] NL_48_q0, NL_48_q1;
    wire [4:0] NL_49_address0, NL_49_address1; wire NL_49_ce0, NL_49_ce1; reg [31:0] NL_49_q0, NL_49_q1;
    wire [4:0] NL_50_address0, NL_50_address1; wire NL_50_ce0, NL_50_ce1; reg [31:0] NL_50_q0, NL_50_q1;
    wire [4:0] NL_51_address0, NL_51_address1; wire NL_51_ce0, NL_51_ce1; reg [31:0] NL_51_q0, NL_51_q1;
    wire [4:0] NL_52_address0, NL_52_address1; wire NL_52_ce0, NL_52_ce1; reg [31:0] NL_52_q0, NL_52_q1;
    wire [4:0] NL_53_address0, NL_53_address1; wire NL_53_ce0, NL_53_ce1; reg [31:0] NL_53_q0, NL_53_q1;
    wire [4:0] NL_54_address0, NL_54_address1; wire NL_54_ce0, NL_54_ce1; reg [31:0] NL_54_q0, NL_54_q1;
    wire [4:0] NL_55_address0, NL_55_address1; wire NL_55_ce0, NL_55_ce1; reg [31:0] NL_55_q0, NL_55_q1;
    wire [4:0] NL_56_address0, NL_56_address1; wire NL_56_ce0, NL_56_ce1; reg [31:0] NL_56_q0, NL_56_q1;
    wire [4:0] NL_57_address0, NL_57_address1; wire NL_57_ce0, NL_57_ce1; reg [31:0] NL_57_q0, NL_57_q1;
    wire [4:0] NL_58_address0, NL_58_address1; wire NL_58_ce0, NL_58_ce1; reg [31:0] NL_58_q0, NL_58_q1;
    wire [4:0] NL_59_address0, NL_59_address1; wire NL_59_ce0, NL_59_ce1; reg [31:0] NL_59_q0, NL_59_q1;
    wire [4:0] NL_60_address0, NL_60_address1; wire NL_60_ce0, NL_60_ce1; reg [31:0] NL_60_q0, NL_60_q1;
    wire [4:0] NL_61_address0, NL_61_address1; wire NL_61_ce0, NL_61_ce1; reg [31:0] NL_61_q0, NL_61_q1;
    wire [4:0] NL_62_address0, NL_62_address1; wire NL_62_ce0, NL_62_ce1; reg [31:0] NL_62_q0, NL_62_q1;
    wire [4:0] NL_63_address0, NL_63_address1; wire NL_63_ce0, NL_63_ce1; reg [31:0] NL_63_q0, NL_63_q1;
    wire [4:0] NL_64_address0, NL_64_address1; wire NL_64_ce0, NL_64_ce1; reg [31:0] NL_64_q0, NL_64_q1;
    wire [4:0] NL_65_address0, NL_65_address1; wire NL_65_ce0, NL_65_ce1; reg [31:0] NL_65_q0, NL_65_q1;
    wire [4:0] NL_66_address0, NL_66_address1; wire NL_66_ce0, NL_66_ce1; reg [31:0] NL_66_q0, NL_66_q1;
    wire [4:0] NL_67_address0, NL_67_address1; wire NL_67_ce0, NL_67_ce1; reg [31:0] NL_67_q0, NL_67_q1;
    wire [4:0] NL_68_address0, NL_68_address1; wire NL_68_ce0, NL_68_ce1; reg [31:0] NL_68_q0, NL_68_q1;
    wire [4:0] NL_69_address0, NL_69_address1; wire NL_69_ce0, NL_69_ce1; reg [31:0] NL_69_q0, NL_69_q1;
    wire [4:0] NL_70_address0, NL_70_address1; wire NL_70_ce0, NL_70_ce1; reg [31:0] NL_70_q0, NL_70_q1;
    wire [4:0] NL_71_address0, NL_71_address1; wire NL_71_ce0, NL_71_ce1; reg [31:0] NL_71_q0, NL_71_q1;
    wire [4:0] NL_72_address0, NL_72_address1; wire NL_72_ce0, NL_72_ce1; reg [31:0] NL_72_q0, NL_72_q1;
    wire [4:0] NL_73_address0, NL_73_address1; wire NL_73_ce0, NL_73_ce1; reg [31:0] NL_73_q0, NL_73_q1;
    wire [4:0] NL_74_address0, NL_74_address1; wire NL_74_ce0, NL_74_ce1; reg [31:0] NL_74_q0, NL_74_q1;
    wire [4:0] NL_75_address0, NL_75_address1; wire NL_75_ce0, NL_75_ce1; reg [31:0] NL_75_q0, NL_75_q1;
    wire [4:0] NL_76_address0, NL_76_address1; wire NL_76_ce0, NL_76_ce1; reg [31:0] NL_76_q0, NL_76_q1;
    wire [4:0] NL_77_address0, NL_77_address1; wire NL_77_ce0, NL_77_ce1; reg [31:0] NL_77_q0, NL_77_q1;
    wire [4:0] NL_78_address0, NL_78_address1; wire NL_78_ce0, NL_78_ce1; reg [31:0] NL_78_q0, NL_78_q1;
    wire [4:0] NL_79_address0, NL_79_address1; wire NL_79_ce0, NL_79_ce1; reg [31:0] NL_79_q0, NL_79_q1;
    wire [4:0] NL_80_address0, NL_80_address1; wire NL_80_ce0, NL_80_ce1; reg [31:0] NL_80_q0, NL_80_q1;
    wire [4:0] NL_81_address0, NL_81_address1; wire NL_81_ce0, NL_81_ce1; reg [31:0] NL_81_q0, NL_81_q1;
    wire [4:0] NL_82_address0, NL_82_address1; wire NL_82_ce0, NL_82_ce1; reg [31:0] NL_82_q0, NL_82_q1;
    wire [4:0] NL_83_address0, NL_83_address1; wire NL_83_ce0, NL_83_ce1; reg [31:0] NL_83_q0, NL_83_q1;
    wire [4:0] NL_84_address0, NL_84_address1; wire NL_84_ce0, NL_84_ce1; reg [31:0] NL_84_q0, NL_84_q1;
    wire [4:0] NL_85_address0, NL_85_address1; wire NL_85_ce0, NL_85_ce1; reg [31:0] NL_85_q0, NL_85_q1;
    wire [4:0] NL_86_address0, NL_86_address1; wire NL_86_ce0, NL_86_ce1; reg [31:0] NL_86_q0, NL_86_q1;
    wire [4:0] NL_87_address0, NL_87_address1; wire NL_87_ce0, NL_87_ce1; reg [31:0] NL_87_q0, NL_87_q1;
    wire [4:0] NL_88_address0, NL_88_address1; wire NL_88_ce0, NL_88_ce1; reg [31:0] NL_88_q0, NL_88_q1;
    wire [4:0] NL_89_address0, NL_89_address1; wire NL_89_ce0, NL_89_ce1; reg [31:0] NL_89_q0, NL_89_q1;
    wire [4:0] NL_90_address0, NL_90_address1; wire NL_90_ce0, NL_90_ce1; reg [31:0] NL_90_q0, NL_90_q1;
    wire [4:0] NL_91_address0, NL_91_address1; wire NL_91_ce0, NL_91_ce1; reg [31:0] NL_91_q0, NL_91_q1;
    wire [4:0] NL_92_address0, NL_92_address1; wire NL_92_ce0, NL_92_ce1; reg [31:0] NL_92_q0, NL_92_q1;
    wire [4:0] NL_93_address0, NL_93_address1; wire NL_93_ce0, NL_93_ce1; reg [31:0] NL_93_q0, NL_93_q1;
    wire [4:0] NL_94_address0, NL_94_address1; wire NL_94_ce0, NL_94_ce1; reg [31:0] NL_94_q0, NL_94_q1;
    wire [4:0] NL_95_address0, NL_95_address1; wire NL_95_ce0, NL_95_ce1; reg [31:0] NL_95_q0, NL_95_q1;
    wire [4:0] NL_96_address0, NL_96_address1; wire NL_96_ce0, NL_96_ce1; reg [31:0] NL_96_q0, NL_96_q1;
    wire [4:0] NL_97_address0, NL_97_address1; wire NL_97_ce0, NL_97_ce1; reg [31:0] NL_97_q0, NL_97_q1;
    wire [4:0] NL_98_address0, NL_98_address1; wire NL_98_ce0, NL_98_ce1; reg [31:0] NL_98_q0, NL_98_q1;
    wire [4:0] NL_99_address0, NL_99_address1; wire NL_99_ce0, NL_99_ce1; reg [31:0] NL_99_q0, NL_99_q1;
    wire [4:0] NL_100_address0, NL_100_address1; wire NL_100_ce0, NL_100_ce1; reg [31:0] NL_100_q0, NL_100_q1;
    wire [4:0] NL_101_address0, NL_101_address1; wire NL_101_ce0, NL_101_ce1; reg [31:0] NL_101_q0, NL_101_q1;
    wire [4:0] NL_102_address0, NL_102_address1; wire NL_102_ce0, NL_102_ce1; reg [31:0] NL_102_q0, NL_102_q1;
    wire [4:0] NL_103_address0, NL_103_address1; wire NL_103_ce0, NL_103_ce1; reg [31:0] NL_103_q0, NL_103_q1;
    wire [4:0] NL_104_address0, NL_104_address1; wire NL_104_ce0, NL_104_ce1; reg [31:0] NL_104_q0, NL_104_q1;
    wire [4:0] NL_105_address0, NL_105_address1; wire NL_105_ce0, NL_105_ce1; reg [31:0] NL_105_q0, NL_105_q1;
    wire [4:0] NL_106_address0, NL_106_address1; wire NL_106_ce0, NL_106_ce1; reg [31:0] NL_106_q0, NL_106_q1;
    wire [4:0] NL_107_address0, NL_107_address1; wire NL_107_ce0, NL_107_ce1; reg [31:0] NL_107_q0, NL_107_q1;
    wire [4:0] NL_108_address0, NL_108_address1; wire NL_108_ce0, NL_108_ce1; reg [31:0] NL_108_q0, NL_108_q1;
    wire [4:0] NL_109_address0, NL_109_address1; wire NL_109_ce0, NL_109_ce1; reg [31:0] NL_109_q0, NL_109_q1;
    wire [4:0] NL_110_address0, NL_110_address1; wire NL_110_ce0, NL_110_ce1; reg [31:0] NL_110_q0, NL_110_q1;
    wire [4:0] NL_111_address0, NL_111_address1; wire NL_111_ce0, NL_111_ce1; reg [31:0] NL_111_q0, NL_111_q1;
    wire [4:0] NL_112_address0, NL_112_address1; wire NL_112_ce0, NL_112_ce1; reg [31:0] NL_112_q0, NL_112_q1;
    wire [4:0] NL_113_address0, NL_113_address1; wire NL_113_ce0, NL_113_ce1; reg [31:0] NL_113_q0, NL_113_q1;
    wire [4:0] NL_114_address0, NL_114_address1; wire NL_114_ce0, NL_114_ce1; reg [31:0] NL_114_q0, NL_114_q1;
    wire [4:0] NL_115_address0, NL_115_address1; wire NL_115_ce0, NL_115_ce1; reg [31:0] NL_115_q0, NL_115_q1;
    wire [4:0] NL_116_address0, NL_116_address1; wire NL_116_ce0, NL_116_ce1; reg [31:0] NL_116_q0, NL_116_q1;
    wire [4:0] NL_117_address0, NL_117_address1; wire NL_117_ce0, NL_117_ce1; reg [31:0] NL_117_q0, NL_117_q1;
    wire [4:0] NL_118_address0, NL_118_address1; wire NL_118_ce0, NL_118_ce1; reg [31:0] NL_118_q0, NL_118_q1;
    wire [4:0] NL_119_address0, NL_119_address1; wire NL_119_ce0, NL_119_ce1; reg [31:0] NL_119_q0, NL_119_q1;
    wire [4:0] NL_120_address0, NL_120_address1; wire NL_120_ce0, NL_120_ce1; reg [31:0] NL_120_q0, NL_120_q1;
    wire [4:0] NL_121_address0, NL_121_address1; wire NL_121_ce0, NL_121_ce1; reg [31:0] NL_121_q0, NL_121_q1;
    wire [4:0] NL_122_address0, NL_122_address1; wire NL_122_ce0, NL_122_ce1; reg [31:0] NL_122_q0, NL_122_q1;
    wire [4:0] NL_123_address0, NL_123_address1; wire NL_123_ce0, NL_123_ce1; reg [31:0] NL_123_q0, NL_123_q1;
    wire [4:0] NL_124_address0, NL_124_address1; wire NL_124_ce0, NL_124_ce1; reg [31:0] NL_124_q0, NL_124_q1;
    wire [4:0] NL_125_address0, NL_125_address1; wire NL_125_ce0, NL_125_ce1; reg [31:0] NL_125_q0, NL_125_q1;
    wire [4:0] NL_126_address0, NL_126_address1; wire NL_126_ce0, NL_126_ce1; reg [31:0] NL_126_q0, NL_126_q1;
    wire [4:0] NL_127_address0, NL_127_address1; wire NL_127_ce0, NL_127_ce1; reg [31:0] NL_127_q0, NL_127_q1;

    // Position Interfaces (Read-Only)
    wire [5:0] position_x_0_address0, position_x_0_address1; wire position_x_0_ce0, position_x_0_ce1; reg [63:0] position_x_0_q0, position_x_0_q1;
    wire [5:0] position_x_1_address0, position_x_1_address1; wire position_x_1_ce0, position_x_1_ce1; reg [63:0] position_x_1_q0, position_x_1_q1;
    wire [5:0] position_x_2_address0, position_x_2_address1; wire position_x_2_ce0, position_x_2_ce1; reg [63:0] position_x_2_q0, position_x_2_q1;
    wire [5:0] position_x_3_address0, position_x_3_address1; wire position_x_3_ce0, position_x_3_ce1; reg [63:0] position_x_3_q0, position_x_3_q1;
    
    wire [4:0] position_y_0_address0, position_y_0_address1; wire position_y_0_ce0, position_y_0_ce1; reg [63:0] position_y_0_q0, position_y_0_q1;
    wire [4:0] position_y_1_address0, position_y_1_address1; wire position_y_1_ce0, position_y_1_ce1; reg [63:0] position_y_1_q0, position_y_1_q1;
    wire [4:0] position_y_2_address0, position_y_2_address1; wire position_y_2_ce0, position_y_2_ce1; reg [63:0] position_y_2_q0, position_y_2_q1;
    wire [4:0] position_y_3_address0, position_y_3_address1; wire position_y_3_ce0, position_y_3_ce1; reg [63:0] position_y_3_q0, position_y_3_q1;
    wire [4:0] position_y_4_address0, position_y_4_address1; wire position_y_4_ce0, position_y_4_ce1; reg [63:0] position_y_4_q0, position_y_4_q1;
    wire [4:0] position_y_5_address0, position_y_5_address1; wire position_y_5_ce0, position_y_5_ce1; reg [63:0] position_y_5_q0, position_y_5_q1;
    wire [4:0] position_y_6_address0, position_y_6_address1; wire position_y_6_ce0, position_y_6_ce1; reg [63:0] position_y_6_q0, position_y_6_q1;
    wire [4:0] position_y_7_address0, position_y_7_address1; wire position_y_7_ce0, position_y_7_ce1; reg [63:0] position_y_7_q0, position_y_7_q1;
    
    wire [4:0] position_z_0_address0, position_z_0_address1; wire position_z_0_ce0, position_z_0_ce1; reg [63:0] position_z_0_q0, position_z_0_q1;
    wire [4:0] position_z_1_address0, position_z_1_address1; wire position_z_1_ce0, position_z_1_ce1; reg [63:0] position_z_1_q0, position_z_1_q1;
    wire [4:0] position_z_2_address0, position_z_2_address1; wire position_z_2_ce0, position_z_2_ce1; reg [63:0] position_z_2_q0, position_z_2_q1;
    wire [4:0] position_z_3_address0, position_z_3_address1; wire position_z_3_ce0, position_z_3_ce1; reg [63:0] position_z_3_q0, position_z_3_q1;
    wire [4:0] position_z_4_address0, position_z_4_address1; wire position_z_4_ce0, position_z_4_ce1; reg [63:0] position_z_4_q0, position_z_4_q1;
    wire [4:0] position_z_5_address0, position_z_5_address1; wire position_z_5_ce0, position_z_5_ce1; reg [63:0] position_z_5_q0, position_z_5_q1;
    wire [4:0] position_z_6_address0, position_z_6_address1; wire position_z_6_ce0, position_z_6_ce1; reg [63:0] position_z_6_q0, position_z_6_q1;
    wire [4:0] position_z_7_address0, position_z_7_address1; wire position_z_7_ce0, position_z_7_ce1; reg [63:0] position_z_7_q0, position_z_7_q1;

    // Force Interfaces (Write-Only)
    wire [7:0] force_x_address0; wire force_x_ce0, force_x_we0; wire [63:0] force_x_d0;
    wire [6:0] force_y_0_address0; wire force_y_0_ce0, force_y_0_we0; wire [63:0] force_y_0_d0;
    wire [6:0] force_y_1_address0; wire force_y_1_ce0, force_y_1_we0; wire [63:0] force_y_1_d0;
    wire [4:0] force_z_0_address0; wire force_z_0_ce0, force_z_0_we0; wire [63:0] force_z_0_d0;
    wire [4:0] force_z_1_address0; wire force_z_1_ce0, force_z_1_we0; wire [63:0] force_z_1_d0;
    wire [4:0] force_z_2_address0; wire force_z_2_ce0, force_z_2_we0; wire [63:0] force_z_2_d0;
    wire [4:0] force_z_3_address0; wire force_z_3_ce0, force_z_3_we0; wire [63:0] force_z_3_d0;
    wire [4:0] force_z_4_address0; wire force_z_4_ce0, force_z_4_we0; wire [63:0] force_z_4_d0;
    wire [4:0] force_z_5_address0; wire force_z_5_ce0, force_z_5_we0; wire [63:0] force_z_5_d0;
    wire [4:0] force_z_6_address0; wire force_z_6_ce0, force_z_6_we0; wire [63:0] force_z_6_d0;
    wire [4:0] force_z_7_address0; wire force_z_7_ce0, force_z_7_we0; wire [63:0] force_z_7_d0;


    // ===================================================================
    // == 2. Testbench Memory Models
    // ===================================================================

    // Models for Read-Only memories (DUT inputs)
    reg [31:0] NL_mem[0:127][0:31]; // 128 memories, each 32 deep
    reg [63:0] position_x_mem[0:3][0:63]; // 4 memories, each 64 deep
    reg [63:0] position_y_mem[0:7][0:31]; // 8 memories, each 32 deep
    reg [63:0] position_z_mem[0:7][0:31]; // 8 memories, each 32 deep

    // Models for Write-Only memories (DUT outputs)
    reg [63:0] force_x_mem[0:255];
    reg [63:0] force_y_mem[0:1][0:127]; // 2 memories, each 128 deep
    reg [63:0] force_z_mem[0:7][0:31];  // 8 memories, each 32 deep


    // ===================================================================
    // == 3. DUT Instantiation
    // ===================================================================
    
    bd_0_wrapper DUT (
        .ap_clk(ap_clk),
        .ap_rst(ap_rst),
        .ap_ctrl_start(ap_ctrl_start),
        .ap_ctrl_done(ap_ctrl_done),
        .ap_ctrl_idle(ap_ctrl_idle),
        .ap_ctrl_ready(ap_ctrl_ready),

        // NL Connections
        .NL_0_address0(NL_0_address0), .NL_0_address1(NL_0_address1), .NL_0_ce0(NL_0_ce0), .NL_0_ce1(NL_0_ce1), .NL_0_q0(NL_0_q0), .NL_0_q1(NL_0_q1),
        .NL_1_address0(NL_1_address0), .NL_1_address1(NL_1_address1), .NL_1_ce0(NL_1_ce0), .NL_1_ce1(NL_1_ce1), .NL_1_q0(NL_1_q0), .NL_1_q1(NL_1_q1),
        .NL_2_address0(NL_2_address0), .NL_2_address1(NL_2_address1), .NL_2_ce0(NL_2_ce0), .NL_2_ce1(NL_2_ce1), .NL_2_q0(NL_2_q0), .NL_2_q1(NL_2_q1),
        .NL_3_address0(NL_3_address0), .NL_3_address1(NL_3_address1), .NL_3_ce0(NL_3_ce0), .NL_3_ce1(NL_3_ce1), .NL_3_q0(NL_3_q0), .NL_3_q1(NL_3_q1),
        .NL_4_address0(NL_4_address0), .NL_4_address1(NL_4_address1), .NL_4_ce0(NL_4_ce0), .NL_4_ce1(NL_4_ce1), .NL_4_q0(NL_4_q0), .NL_4_q1(NL_4_q1),
        .NL_5_address0(NL_5_address0), .NL_5_address1(NL_5_address1), .NL_5_ce0(NL_5_ce0), .NL_5_ce1(NL_5_ce1), .NL_5_q0(NL_5_q0), .NL_5_q1(NL_5_q1),
        .NL_6_address0(NL_6_address0), .NL_6_address1(NL_6_address1), .NL_6_ce0(NL_6_ce0), .NL_6_ce1(NL_6_ce1), .NL_6_q0(NL_6_q0), .NL_6_q1(NL_6_q1),
        .NL_7_address0(NL_7_address0), .NL_7_address1(NL_7_address1), .NL_7_ce0(NL_7_ce0), .NL_7_ce1(NL_7_ce1), .NL_7_q0(NL_7_q0), .NL_7_q1(NL_7_q1),
        .NL_8_address0(NL_8_address0), .NL_8_address1(NL_8_address1), .NL_8_ce0(NL_8_ce0), .NL_8_ce1(NL_8_ce1), .NL_8_q0(NL_8_q0), .NL_8_q1(NL_8_q1),
        .NL_9_address0(NL_9_address0), .NL_9_address1(NL_9_address1), .NL_9_ce0(NL_9_ce0), .NL_9_ce1(NL_9_ce1), .NL_9_q0(NL_9_q0), .NL_9_q1(NL_9_q1),
        .NL_10_address0(NL_10_address0), .NL_10_address1(NL_10_address1), .NL_10_ce0(NL_10_ce0), .NL_10_ce1(NL_10_ce1), .NL_10_q0(NL_10_q0), .NL_10_q1(NL_10_q1),
        .NL_11_address0(NL_11_address0), .NL_11_address1(NL_11_address1), .NL_11_ce0(NL_11_ce0), .NL_11_ce1(NL_11_ce1), .NL_11_q0(NL_11_q0), .NL_11_q1(NL_11_q1),
        .NL_12_address0(NL_12_address0), .NL_12_address1(NL_12_address1), .NL_12_ce0(NL_12_ce0), .NL_12_ce1(NL_12_ce1), .NL_12_q0(NL_12_q0), .NL_12_q1(NL_12_q1),
        .NL_13_address0(NL_13_address0), .NL_13_address1(NL_13_address1), .NL_13_ce0(NL_13_ce0), .NL_13_ce1(NL_13_ce1), .NL_13_q0(NL_13_q0), .NL_13_q1(NL_13_q1),
        .NL_14_address0(NL_14_address0), .NL_14_address1(NL_14_address1), .NL_14_ce0(NL_14_ce0), .NL_14_ce1(NL_14_ce1), .NL_14_q0(NL_14_q0), .NL_14_q1(NL_14_q1),
        .NL_15_address0(NL_15_address0), .NL_15_address1(NL_15_address1), .NL_15_ce0(NL_15_ce0), .NL_15_ce1(NL_15_ce1), .NL_15_q0(NL_15_q0), .NL_15_q1(NL_15_q1),
        .NL_16_address0(NL_16_address0), .NL_16_address1(NL_16_address1), .NL_16_ce0(NL_16_ce0), .NL_16_ce1(NL_16_ce1), .NL_16_q0(NL_16_q0), .NL_16_q1(NL_16_q1),
        .NL_17_address0(NL_17_address0), .NL_17_address1(NL_17_address1), .NL_17_ce0(NL_17_ce0), .NL_17_ce1(NL_17_ce1), .NL_17_q0(NL_17_q0), .NL_17_q1(NL_17_q1),
        .NL_18_address0(NL_18_address0), .NL_18_address1(NL_18_address1), .NL_18_ce0(NL_18_ce0), .NL_18_ce1(NL_18_ce1), .NL_18_q0(NL_18_q0), .NL_18_q1(NL_18_q1),
        .NL_19_address0(NL_19_address0), .NL_19_address1(NL_19_address1), .NL_19_ce0(NL_19_ce0), .NL_19_ce1(NL_19_ce1), .NL_19_q0(NL_19_q0), .NL_19_q1(NL_19_q1),
        .NL_20_address0(NL_20_address0), .NL_20_address1(NL_20_address1), .NL_20_ce0(NL_20_ce0), .NL_20_ce1(NL_20_ce1), .NL_20_q0(NL_20_q0), .NL_20_q1(NL_20_q1),
        .NL_21_address0(NL_21_address0), .NL_21_address1(NL_21_address1), .NL_21_ce0(NL_21_ce0), .NL_21_ce1(NL_21_ce1), .NL_21_q0(NL_21_q0), .NL_21_q1(NL_21_q1),
        .NL_22_address0(NL_22_address0), .NL_22_address1(NL_22_address1), .NL_22_ce0(NL_22_ce0), .NL_22_ce1(NL_22_ce1), .NL_22_q0(NL_22_q0), .NL_22_q1(NL_22_q1),
        .NL_23_address0(NL_23_address0), .NL_23_address1(NL_23_address1), .NL_23_ce0(NL_23_ce0), .NL_23_ce1(NL_23_ce1), .NL_23_q0(NL_23_q0), .NL_23_q1(NL_23_q1),
        .NL_24_address0(NL_24_address0), .NL_24_address1(NL_24_address1), .NL_24_ce0(NL_24_ce0), .NL_24_ce1(NL_24_ce1), .NL_24_q0(NL_24_q0), .NL_24_q1(NL_24_q1),
        .NL_25_address0(NL_25_address0), .NL_25_address1(NL_25_address1), .NL_25_ce0(NL_25_ce0), .NL_25_ce1(NL_25_ce1), .NL_25_q0(NL_25_q0), .NL_25_q1(NL_25_q1),
        .NL_26_address0(NL_26_address0), .NL_26_address1(NL_26_address1), .NL_26_ce0(NL_26_ce0), .NL_26_ce1(NL_26_ce1), .NL_26_q0(NL_26_q0), .NL_26_q1(NL_26_q1),
        .NL_27_address0(NL_27_address0), .NL_27_address1(NL_27_address1), .NL_27_ce0(NL_27_ce0), .NL_27_ce1(NL_27_ce1), .NL_27_q0(NL_27_q0), .NL_27_q1(NL_27_q1),
        .NL_28_address0(NL_28_address0), .NL_28_address1(NL_28_address1), .NL_28_ce0(NL_28_ce0), .NL_28_ce1(NL_28_ce1), .NL_28_q0(NL_28_q0), .NL_28_q1(NL_28_q1),
        .NL_29_address0(NL_29_address0), .NL_29_address1(NL_29_address1), .NL_29_ce0(NL_29_ce0), .NL_29_ce1(NL_29_ce1), .NL_29_q0(NL_29_q0), .NL_29_q1(NL_29_q1),
        .NL_30_address0(NL_30_address0), .NL_30_address1(NL_30_address1), .NL_30_ce0(NL_30_ce0), .NL_30_ce1(NL_30_ce1), .NL_30_q0(NL_30_q0), .NL_30_q1(NL_30_q1),
        .NL_31_address0(NL_31_address0), .NL_31_address1(NL_31_address1), .NL_31_ce0(NL_31_ce0), .NL_31_ce1(NL_31_ce1), .NL_31_q0(NL_31_q0), .NL_31_q1(NL_31_q1),
        .NL_32_address0(NL_32_address0), .NL_32_address1(NL_32_address1), .NL_32_ce0(NL_32_ce0), .NL_32_ce1(NL_32_ce1), .NL_32_q0(NL_32_q0), .NL_32_q1(NL_32_q1),
        .NL_33_address0(NL_33_address0), .NL_33_address1(NL_33_address1), .NL_33_ce0(NL_33_ce0), .NL_33_ce1(NL_33_ce1), .NL_33_q0(NL_33_q0), .NL_33_q1(NL_33_q1),
        .NL_34_address0(NL_34_address0), .NL_34_address1(NL_34_address1), .NL_34_ce0(NL_34_ce0), .NL_34_ce1(NL_34_ce1), .NL_34_q0(NL_34_q0), .NL_34_q1(NL_34_q1),
        .NL_35_address0(NL_35_address0), .NL_35_address1(NL_35_address1), .NL_35_ce0(NL_35_ce0), .NL_35_ce1(NL_35_ce1), .NL_35_q0(NL_35_q0), .NL_35_q1(NL_35_q1),
        .NL_36_address0(NL_36_address0), .NL_36_address1(NL_36_address1), .NL_36_ce0(NL_36_ce0), .NL_36_ce1(NL_36_ce1), .NL_36_q0(NL_36_q0), .NL_36_q1(NL_36_q1),
        .NL_37_address0(NL_37_address0), .NL_37_address1(NL_37_address1), .NL_37_ce0(NL_37_ce0), .NL_37_ce1(NL_37_ce1), .NL_37_q0(NL_37_q0), .NL_37_q1(NL_37_q1),
        .NL_38_address0(NL_38_address0), .NL_38_address1(NL_38_address1), .NL_38_ce0(NL_38_ce0), .NL_38_ce1(NL_38_ce1), .NL_38_q0(NL_38_q0), .NL_38_q1(NL_38_q1),
        .NL_39_address0(NL_39_address0), .NL_39_address1(NL_39_address1), .NL_39_ce0(NL_39_ce0), .NL_39_ce1(NL_39_ce1), .NL_39_q0(NL_39_q0), .NL_39_q1(NL_39_q1),
        .NL_40_address0(NL_40_address0), .NL_40_address1(NL_40_address1), .NL_40_ce0(NL_40_ce0), .NL_40_ce1(NL_40_ce1), .NL_40_q0(NL_40_q0), .NL_40_q1(NL_40_q1),
        .NL_41_address0(NL_41_address0), .NL_41_address1(NL_41_address1), .NL_41_ce0(NL_41_ce0), .NL_41_ce1(NL_41_ce1), .NL_41_q0(NL_41_q0), .NL_41_q1(NL_41_q1),
        .NL_42_address0(NL_42_address0), .NL_42_address1(NL_42_address1), .NL_42_ce0(NL_42_ce0), .NL_42_ce1(NL_42_ce1), .NL_42_q0(NL_42_q0), .NL_42_q1(NL_42_q1),
        .NL_43_address0(NL_43_address0), .NL_43_address1(NL_43_address1), .NL_43_ce0(NL_43_ce0), .NL_43_ce1(NL_43_ce1), .NL_43_q0(NL_43_q0), .NL_43_q1(NL_43_q1),
        .NL_44_address0(NL_44_address0), .NL_44_address1(NL_44_address1), .NL_44_ce0(NL_44_ce0), .NL_44_ce1(NL_44_ce1), .NL_44_q0(NL_44_q0), .NL_44_q1(NL_44_q1),
        .NL_45_address0(NL_45_address0), .NL_45_address1(NL_45_address1), .NL_45_ce0(NL_45_ce0), .NL_45_ce1(NL_45_ce1), .NL_45_q0(NL_45_q0), .NL_45_q1(NL_45_q1),
        .NL_46_address0(NL_46_address0), .NL_46_address1(NL_46_address1), .NL_46_ce0(NL_46_ce0), .NL_46_ce1(NL_46_ce1), .NL_46_q0(NL_46_q0), .NL_46_q1(NL_46_q1),
        .NL_47_address0(NL_47_address0), .NL_47_address1(NL_47_address1), .NL_47_ce0(NL_47_ce0), .NL_47_ce1(NL_47_ce1), .NL_47_q0(NL_47_q0), .NL_47_q1(NL_47_q1),
        .NL_48_address0(NL_48_address0), .NL_48_address1(NL_48_address1), .NL_48_ce0(NL_48_ce0), .NL_48_ce1(NL_48_ce1), .NL_48_q0(NL_48_q0), .NL_48_q1(NL_48_q1),
        .NL_49_address0(NL_49_address0), .NL_49_address1(NL_49_address1), .NL_49_ce0(NL_49_ce0), .NL_49_ce1(NL_49_ce1), .NL_49_q0(NL_49_q0), .NL_49_q1(NL_49_q1),
        .NL_50_address0(NL_50_address0), .NL_50_address1(NL_50_address1), .NL_50_ce0(NL_50_ce0), .NL_50_ce1(NL_50_ce1), .NL_50_q0(NL_50_q0), .NL_50_q1(NL_50_q1),
        .NL_51_address0(NL_51_address0), .NL_51_address1(NL_51_address1), .NL_51_ce0(NL_51_ce0), .NL_51_ce1(NL_51_ce1), .NL_51_q0(NL_51_q0), .NL_51_q1(NL_51_q1),
        .NL_52_address0(NL_52_address0), .NL_52_address1(NL_52_address1), .NL_52_ce0(NL_52_ce0), .NL_52_ce1(NL_52_ce1), .NL_52_q0(NL_52_q0), .NL_52_q1(NL_52_q1),
        .NL_53_address0(NL_53_address0), .NL_53_address1(NL_53_address1), .NL_53_ce0(NL_53_ce0), .NL_53_ce1(NL_53_ce1), .NL_53_q0(NL_53_q0), .NL_53_q1(NL_53_q1),
        .NL_54_address0(NL_54_address0), .NL_54_address1(NL_54_address1), .NL_54_ce0(NL_54_ce0), .NL_54_ce1(NL_54_ce1), .NL_54_q0(NL_54_q0), .NL_54_q1(NL_54_q1),
        .NL_55_address0(NL_55_address0), .NL_55_address1(NL_55_address1), .NL_55_ce0(NL_55_ce0), .NL_55_ce1(NL_55_ce1), .NL_55_q0(NL_55_q0), .NL_55_q1(NL_55_q1),
        .NL_56_address0(NL_56_address0), .NL_56_address1(NL_56_address1), .NL_56_ce0(NL_56_ce0), .NL_56_ce1(NL_56_ce1), .NL_56_q0(NL_56_q0), .NL_56_q1(NL_56_q1),
        .NL_57_address0(NL_57_address0), .NL_57_address1(NL_57_address1), .NL_57_ce0(NL_57_ce0), .NL_57_ce1(NL_57_ce1), .NL_57_q0(NL_57_q0), .NL_57_q1(NL_57_q1),
        .NL_58_address0(NL_58_address0), .NL_58_address1(NL_58_address1), .NL_58_ce0(NL_58_ce0), .NL_58_ce1(NL_58_ce1), .NL_58_q0(NL_58_q0), .NL_58_q1(NL_58_q1),
        .NL_59_address0(NL_59_address0), .NL_59_address1(NL_59_address1), .NL_59_ce0(NL_59_ce0), .NL_59_ce1(NL_59_ce1), .NL_59_q0(NL_59_q0), .NL_59_q1(NL_59_q1),
        .NL_60_address0(NL_60_address0), .NL_60_address1(NL_60_address1), .NL_60_ce0(NL_60_ce0), .NL_60_ce1(NL_60_ce1), .NL_60_q0(NL_60_q0), .NL_60_q1(NL_60_q1),
        .NL_61_address0(NL_61_address0), .NL_61_address1(NL_61_address1), .NL_61_ce0(NL_61_ce0), .NL_61_ce1(NL_61_ce1), .NL_61_q0(NL_61_q0), .NL_61_q1(NL_61_q1),
        .NL_62_address0(NL_62_address0), .NL_62_address1(NL_62_address1), .NL_62_ce0(NL_62_ce0), .NL_62_ce1(NL_62_ce1), .NL_62_q0(NL_62_q0), .NL_62_q1(NL_62_q1),
        .NL_63_address0(NL_63_address0), .NL_63_address1(NL_63_address1), .NL_63_ce0(NL_63_ce0), .NL_63_ce1(NL_63_ce1), .NL_63_q0(NL_63_q0), .NL_63_q1(NL_63_q1),
        .NL_64_address0(NL_64_address0), .NL_64_address1(NL_64_address1), .NL_64_ce0(NL_64_ce0), .NL_64_ce1(NL_64_ce1), .NL_64_q0(NL_64_q0), .NL_64_q1(NL_64_q1),
        .NL_65_address0(NL_65_address0), .NL_65_address1(NL_65_address1), .NL_65_ce0(NL_65_ce0), .NL_65_ce1(NL_65_ce1), .NL_65_q0(NL_65_q0), .NL_65_q1(NL_65_q1),
        .NL_66_address0(NL_66_address0), .NL_66_address1(NL_66_address1), .NL_66_ce0(NL_66_ce0), .NL_66_ce1(NL_66_ce1), .NL_66_q0(NL_66_q0), .NL_66_q1(NL_66_q1),
        .NL_67_address0(NL_67_address0), .NL_67_address1(NL_67_address1), .NL_67_ce0(NL_67_ce0), .NL_67_ce1(NL_67_ce1), .NL_67_q0(NL_67_q0), .NL_67_q1(NL_67_q1),
        .NL_68_address0(NL_68_address0), .NL_68_address1(NL_68_address1), .NL_68_ce0(NL_68_ce0), .NL_68_ce1(NL_68_ce1), .NL_68_q0(NL_68_q0), .NL_68_q1(NL_68_q1),
        .NL_69_address0(NL_69_address0), .NL_69_address1(NL_69_address1), .NL_69_ce0(NL_69_ce0), .NL_69_ce1(NL_69_ce1), .NL_69_q0(NL_69_q0), .NL_69_q1(NL_69_q1),
        .NL_70_address0(NL_70_address0), .NL_70_address1(NL_70_address1), .NL_70_ce0(NL_70_ce0), .NL_70_ce1(NL_70_ce1), .NL_70_q0(NL_70_q0), .NL_70_q1(NL_70_q1),
        .NL_71_address0(NL_71_address0), .NL_71_address1(NL_71_address1), .NL_71_ce0(NL_71_ce0), .NL_71_ce1(NL_71_ce1), .NL_71_q0(NL_71_q0), .NL_71_q1(NL_71_q1),
        .NL_72_address0(NL_72_address0), .NL_72_address1(NL_72_address1), .NL_72_ce0(NL_72_ce0), .NL_72_ce1(NL_72_ce1), .NL_72_q0(NL_72_q0), .NL_72_q1(NL_72_q1),
        .NL_73_address0(NL_73_address0), .NL_73_address1(NL_73_address1), .NL_73_ce0(NL_73_ce0), .NL_73_ce1(NL_73_ce1), .NL_73_q0(NL_73_q0), .NL_73_q1(NL_73_q1),
        .NL_74_address0(NL_74_address0), .NL_74_address1(NL_74_address1), .NL_74_ce0(NL_74_ce0), .NL_74_ce1(NL_74_ce1), .NL_74_q0(NL_74_q0), .NL_74_q1(NL_74_q1),
        .NL_75_address0(NL_75_address0), .NL_75_address1(NL_75_address1), .NL_75_ce0(NL_75_ce0), .NL_75_ce1(NL_75_ce1), .NL_75_q0(NL_75_q0), .NL_75_q1(NL_75_q1),
        .NL_76_address0(NL_76_address0), .NL_76_address1(NL_76_address1), .NL_76_ce0(NL_76_ce0), .NL_76_ce1(NL_76_ce1), .NL_76_q0(NL_76_q0), .NL_76_q1(NL_76_q1),
        .NL_77_address0(NL_77_address0), .NL_77_address1(NL_77_address1), .NL_77_ce0(NL_77_ce0), .NL_77_ce1(NL_77_ce1), .NL_77_q0(NL_77_q0), .NL_77_q1(NL_77_q1),
        .NL_78_address0(NL_78_address0), .NL_78_address1(NL_78_address1), .NL_78_ce0(NL_78_ce0), .NL_78_ce1(NL_78_ce1), .NL_78_q0(NL_78_q0), .NL_78_q1(NL_78_q1),
        .NL_79_address0(NL_79_address0), .NL_79_address1(NL_79_address1), .NL_79_ce0(NL_79_ce0), .NL_79_ce1(NL_79_ce1), .NL_79_q0(NL_79_q0), .NL_79_q1(NL_79_q1),
        .NL_80_address0(NL_80_address0), .NL_80_address1(NL_80_address1), .NL_80_ce0(NL_80_ce0), .NL_80_ce1(NL_80_ce1), .NL_80_q0(NL_80_q0), .NL_80_q1(NL_80_q1),
        .NL_81_address0(NL_81_address0), .NL_81_address1(NL_81_address1), .NL_81_ce0(NL_81_ce0), .NL_81_ce1(NL_81_ce1), .NL_81_q0(NL_81_q0), .NL_81_q1(NL_81_q1),
        .NL_82_address0(NL_82_address0), .NL_82_address1(NL_82_address1), .NL_82_ce0(NL_82_ce0), .NL_82_ce1(NL_82_ce1), .NL_82_q0(NL_82_q0), .NL_82_q1(NL_82_q1),
        .NL_83_address0(NL_83_address0), .NL_83_address1(NL_83_address1), .NL_83_ce0(NL_83_ce0), .NL_83_ce1(NL_83_ce1), .NL_83_q0(NL_83_q0), .NL_83_q1(NL_83_q1),
        .NL_84_address0(NL_84_address0), .NL_84_address1(NL_84_address1), .NL_84_ce0(NL_84_ce0), .NL_84_ce1(NL_84_ce1), .NL_84_q0(NL_84_q0), .NL_84_q1(NL_84_q1),
        .NL_85_address0(NL_85_address0), .NL_85_address1(NL_85_address1), .NL_85_ce0(NL_85_ce0), .NL_85_ce1(NL_85_ce1), .NL_85_q0(NL_85_q0), .NL_85_q1(NL_85_q1),
        .NL_86_address0(NL_86_address0), .NL_86_address1(NL_86_address1), .NL_86_ce0(NL_86_ce0), .NL_86_ce1(NL_86_ce1), .NL_86_q0(NL_86_q0), .NL_86_q1(NL_86_q1),
        .NL_87_address0(NL_87_address0), .NL_87_address1(NL_87_address1), .NL_87_ce0(NL_87_ce0), .NL_87_ce1(NL_87_ce1), .NL_87_q0(NL_87_q0), .NL_87_q1(NL_87_q1),
        .NL_88_address0(NL_88_address0), .NL_88_address1(NL_88_address1), .NL_88_ce0(NL_88_ce0), .NL_88_ce1(NL_88_ce1), .NL_88_q0(NL_88_q0), .NL_88_q1(NL_88_q1),
        .NL_89_address0(NL_89_address0), .NL_89_address1(NL_89_address1), .NL_89_ce0(NL_89_ce0), .NL_89_ce1(NL_89_ce1), .NL_89_q0(NL_89_q0), .NL_89_q1(NL_89_q1),
        .NL_90_address0(NL_90_address0), .NL_90_address1(NL_90_address1), .NL_90_ce0(NL_90_ce0), .NL_90_ce1(NL_90_ce1), .NL_90_q0(NL_90_q0), .NL_90_q1(NL_90_q1),
        .NL_91_address0(NL_91_address0), .NL_91_address1(NL_91_address1), .NL_91_ce0(NL_91_ce0), .NL_91_ce1(NL_91_ce1), .NL_91_q0(NL_91_q0), .NL_91_q1(NL_91_q1),
        .NL_92_address0(NL_92_address0), .NL_92_address1(NL_92_address1), .NL_92_ce0(NL_92_ce0), .NL_92_ce1(NL_92_ce1), .NL_92_q0(NL_92_q0), .NL_92_q1(NL_92_q1),
        .NL_93_address0(NL_93_address0), .NL_93_address1(NL_93_address1), .NL_93_ce0(NL_93_ce0), .NL_93_ce1(NL_93_ce1), .NL_93_q0(NL_93_q0), .NL_93_q1(NL_93_q1),
        .NL_94_address0(NL_94_address0), .NL_94_address1(NL_94_address1), .NL_94_ce0(NL_94_ce0), .NL_94_ce1(NL_94_ce1), .NL_94_q0(NL_94_q0), .NL_94_q1(NL_94_q1),
        .NL_95_address0(NL_95_address0), .NL_95_address1(NL_95_address1), .NL_95_ce0(NL_95_ce0), .NL_95_ce1(NL_95_ce1), .NL_95_q0(NL_95_q0), .NL_95_q1(NL_95_q1),
        .NL_96_address0(NL_96_address0), .NL_96_address1(NL_96_address1), .NL_96_ce0(NL_96_ce0), .NL_96_ce1(NL_96_ce1), .NL_96_q0(NL_96_q0), .NL_96_q1(NL_96_q1),
        .NL_97_address0(NL_97_address0), .NL_97_address1(NL_97_address1), .NL_97_ce0(NL_97_ce0), .NL_97_ce1(NL_97_ce1), .NL_97_q0(NL_97_q0), .NL_97_q1(NL_97_q1),
        .NL_98_address0(NL_98_address0), .NL_98_address1(NL_98_address1), .NL_98_ce0(NL_98_ce0), .NL_98_ce1(NL_98_ce1), .NL_98_q0(NL_98_q0), .NL_98_q1(NL_98_q1),
        .NL_99_address0(NL_99_address0), .NL_99_address1(NL_99_address1), .NL_99_ce0(NL_99_ce0), .NL_99_ce1(NL_99_ce1), .NL_99_q0(NL_99_q0), .NL_99_q1(NL_99_q1),
        .NL_100_address0(NL_100_address0), .NL_100_address1(NL_100_address1), .NL_100_ce0(NL_100_ce0), .NL_100_ce1(NL_100_ce1), .NL_100_q0(NL_100_q0), .NL_100_q1(NL_100_q1),
        .NL_101_address0(NL_101_address0), .NL_101_address1(NL_101_address1), .NL_101_ce0(NL_101_ce0), .NL_101_ce1(NL_101_ce1), .NL_101_q0(NL_101_q0), .NL_101_q1(NL_101_q1),
        .NL_102_address0(NL_102_address0), .NL_102_address1(NL_102_address1), .NL_102_ce0(NL_102_ce0), .NL_102_ce1(NL_102_ce1), .NL_102_q0(NL_102_q0), .NL_102_q1(NL_102_q1),
        .NL_103_address0(NL_103_address0), .NL_103_address1(NL_103_address1), .NL_103_ce0(NL_103_ce0), .NL_103_ce1(NL_103_ce1), .NL_103_q0(NL_103_q0), .NL_103_q1(NL_103_q1),
        .NL_104_address0(NL_104_address0), .NL_104_address1(NL_104_address1), .NL_104_ce0(NL_104_ce0), .NL_104_ce1(NL_104_ce1), .NL_104_q0(NL_104_q0), .NL_104_q1(NL_104_q1),
        .NL_105_address0(NL_105_address0), .NL_105_address1(NL_105_address1), .NL_105_ce0(NL_105_ce0), .NL_105_ce1(NL_105_ce1), .NL_105_q0(NL_105_q0), .NL_105_q1(NL_105_q1),
        .NL_106_address0(NL_106_address0), .NL_106_address1(NL_106_address1), .NL_106_ce0(NL_106_ce0), .NL_106_ce1(NL_106_ce1), .NL_106_q0(NL_106_q0), .NL_106_q1(NL_106_q1),
        .NL_107_address0(NL_107_address0), .NL_107_address1(NL_107_address1), .NL_107_ce0(NL_107_ce0), .NL_107_ce1(NL_107_ce1), .NL_107_q0(NL_107_q0), .NL_107_q1(NL_107_q1),
        .NL_108_address0(NL_108_address0), .NL_108_address1(NL_108_address1), .NL_108_ce0(NL_108_ce0), .NL_108_ce1(NL_108_ce1), .NL_108_q0(NL_108_q0), .NL_108_q1(NL_108_q1),
        .NL_109_address0(NL_109_address0), .NL_109_address1(NL_109_address1), .NL_109_ce0(NL_109_ce0), .NL_109_ce1(NL_109_ce1), .NL_109_q0(NL_109_q0), .NL_109_q1(NL_109_q1),
        .NL_110_address0(NL_110_address0), .NL_110_address1(NL_110_address1), .NL_110_ce0(NL_110_ce0), .NL_110_ce1(NL_110_ce1), .NL_110_q0(NL_110_q0), .NL_110_q1(NL_110_q1),
        .NL_111_address0(NL_111_address0), .NL_111_address1(NL_111_address1), .NL_111_ce0(NL_111_ce0), .NL_111_ce1(NL_111_ce1), .NL_111_q0(NL_111_q0), .NL_111_q1(NL_111_q1),
        .NL_112_address0(NL_112_address0), .NL_112_address1(NL_112_address1), .NL_112_ce0(NL_112_ce0), .NL_112_ce1(NL_112_ce1), .NL_112_q0(NL_112_q0), .NL_112_q1(NL_112_q1),
        .NL_113_address0(NL_113_address0), .NL_113_address1(NL_113_address1), .NL_113_ce0(NL_113_ce0), .NL_113_ce1(NL_113_ce1), .NL_113_q0(NL_113_q0), .NL_113_q1(NL_113_q1),
        .NL_114_address0(NL_114_address0), .NL_114_address1(NL_114_address1), .NL_114_ce0(NL_114_ce0), .NL_114_ce1(NL_114_ce1), .NL_114_q0(NL_114_q0), .NL_114_q1(NL_114_q1),
        .NL_115_address0(NL_115_address0), .NL_115_address1(NL_115_address1), .NL_115_ce0(NL_115_ce0), .NL_115_ce1(NL_115_ce1), .NL_115_q0(NL_115_q0), .NL_115_q1(NL_115_q1),
        .NL_116_address0(NL_116_address0), .NL_116_address1(NL_116_address1), .NL_116_ce0(NL_116_ce0), .NL_116_ce1(NL_116_ce1), .NL_116_q0(NL_116_q0), .NL_116_q1(NL_116_q1),
        .NL_117_address0(NL_117_address0), .NL_117_address1(NL_117_address1), .NL_117_ce0(NL_117_ce0), .NL_117_ce1(NL_117_ce1), .NL_117_q0(NL_117_q0), .NL_117_q1(NL_117_q1),
        .NL_118_address0(NL_118_address0), .NL_118_address1(NL_118_address1), .NL_118_ce0(NL_118_ce0), .NL_118_ce1(NL_118_ce1), .NL_118_q0(NL_118_q0), .NL_118_q1(NL_118_q1),
        .NL_119_address0(NL_119_address0), .NL_119_address1(NL_119_address1), .NL_119_ce0(NL_119_ce0), .NL_119_ce1(NL_119_ce1), .NL_119_q0(NL_119_q0), .NL_119_q1(NL_119_q1),
        .NL_120_address0(NL_120_address0), .NL_120_address1(NL_120_address1), .NL_120_ce0(NL_120_ce0), .NL_120_ce1(NL_120_ce1), .NL_120_q0(NL_120_q0), .NL_120_q1(NL_120_q1),
        .NL_121_address0(NL_121_address0), .NL_121_address1(NL_121_address1), .NL_121_ce0(NL_121_ce0), .NL_121_ce1(NL_121_ce1), .NL_121_q0(NL_121_q0), .NL_121_q1(NL_121_q1),
        .NL_122_address0(NL_122_address0), .NL_122_address1(NL_122_address1), .NL_122_ce0(NL_122_ce0), .NL_122_ce1(NL_122_ce1), .NL_122_q0(NL_122_q0), .NL_122_q1(NL_122_q1),
        .NL_123_address0(NL_123_address0), .NL_123_address1(NL_123_address1), .NL_123_ce0(NL_123_ce0), .NL_123_ce1(NL_123_ce1), .NL_123_q0(NL_123_q0), .NL_123_q1(NL_123_q1),
        .NL_124_address0(NL_124_address0), .NL_124_address1(NL_124_address1), .NL_124_ce0(NL_124_ce0), .NL_124_ce1(NL_124_ce1), .NL_124_q0(NL_124_q0), .NL_124_q1(NL_124_q1),
        .NL_125_address0(NL_125_address0), .NL_125_address1(NL_125_address1), .NL_125_ce0(NL_125_ce0), .NL_125_ce1(NL_125_ce1), .NL_125_q0(NL_125_q0), .NL_125_q1(NL_125_q1),
        .NL_126_address0(NL_126_address0), .NL_126_address1(NL_126_address1), .NL_126_ce0(NL_126_ce0), .NL_126_ce1(NL_126_ce1), .NL_126_q0(NL_126_q0), .NL_126_q1(NL_126_q1),
        .NL_127_address0(NL_127_address0), .NL_127_address1(NL_127_address1), .NL_127_ce0(NL_127_ce0), .NL_127_ce1(NL_127_ce1), .NL_127_q0(NL_127_q0), .NL_127_q1(NL_127_q1),

        // Position Connections
        .position_x_0_address0(position_x_0_address0), .position_x_0_address1(position_x_0_address1), .position_x_0_ce0(position_x_0_ce0), .position_x_0_ce1(position_x_0_ce1), .position_x_0_q0(position_x_0_q0), .position_x_0_q1(position_x_0_q1),
        .position_x_1_address0(position_x_1_address0), .position_x_1_address1(position_x_1_address1), .position_x_1_ce0(position_x_1_ce0), .position_x_1_ce1(position_x_1_ce1), .position_x_1_q0(position_x_1_q0), .position_x_1_q1(position_x_1_q1),
        .position_x_2_address0(position_x_2_address0), .position_x_2_address1(position_x_2_address1), .position_x_2_ce0(position_x_2_ce0), .position_x_2_ce1(position_x_2_ce1), .position_x_2_q0(position_x_2_q0), .position_x_2_q1(position_x_2_q1),
        .position_x_3_address0(position_x_3_address0), .position_x_3_address1(position_x_3_address1), .position_x_3_ce0(position_x_3_ce0), .position_x_3_ce1(position_x_3_ce1), .position_x_3_q0(position_x_3_q0), .position_x_3_q1(position_x_3_q1),
        .position_y_0_address0(position_y_0_address0), .position_y_0_address1(position_y_0_address1), .position_y_0_ce0(position_y_0_ce0), .position_y_0_ce1(position_y_0_ce1), .position_y_0_q0(position_y_0_q0), .position_y_0_q1(position_y_0_q1),
        .position_y_1_address0(position_y_1_address0), .position_y_1_address1(position_y_1_address1), .position_y_1_ce0(position_y_1_ce0), .position_y_1_ce1(position_y_1_ce1), .position_y_1_q0(position_y_1_q0), .position_y_1_q1(position_y_1_q1),
        .position_y_2_address0(position_y_2_address0), .position_y_2_address1(position_y_2_address1), .position_y_2_ce0(position_y_2_ce0), .position_y_2_ce1(position_y_2_ce1), .position_y_2_q0(position_y_2_q0), .position_y_2_q1(position_y_2_q1),
        .position_y_3_address0(position_y_3_address0), .position_y_3_address1(position_y_3_address1), .position_y_3_ce0(position_y_3_ce0), .position_y_3_ce1(position_y_3_ce1), .position_y_3_q0(position_y_3_q0), .position_y_3_q1(position_y_3_q1),
        .position_y_4_address0(position_y_4_address0), .position_y_4_address1(position_y_4_address1), .position_y_4_ce0(position_y_4_ce0), .position_y_4_ce1(position_y_4_ce1), .position_y_4_q0(position_y_4_q0), .position_y_4_q1(position_y_4_q1),
        .position_y_5_address0(position_y_5_address0), .position_y_5_address1(position_y_5_address1), .position_y_5_ce0(position_y_5_ce0), .position_y_5_ce1(position_y_5_ce1), .position_y_5_q0(position_y_5_q0), .position_y_5_q1(position_y_5_q1),
        .position_y_6_address0(position_y_6_address0), .position_y_6_address1(position_y_6_address1), .position_y_6_ce0(position_y_6_ce0), .position_y_6_ce1(position_y_6_ce1), .position_y_6_q0(position_y_6_q0), .position_y_6_q1(position_y_6_q1),
        .position_y_7_address0(position_y_7_address0), .position_y_7_address1(position_y_7_address1), .position_y_7_ce0(position_y_7_ce0), .position_y_7_ce1(position_y_7_ce1), .position_y_7_q0(position_y_7_q0), .position_y_7_q1(position_y_7_q1),
        .position_z_0_address0(position_z_0_address0), .position_z_0_address1(position_z_0_address1), .position_z_0_ce0(position_z_0_ce0), .position_z_0_ce1(position_z_0_ce1), .position_z_0_q0(position_z_0_q0), .position_z_0_q1(position_z_0_q1),
        .position_z_1_address0(position_z_1_address0), .position_z_1_address1(position_z_1_address1), .position_z_1_ce0(position_z_1_ce0), .position_z_1_ce1(position_z_1_ce1), .position_z_1_q0(position_z_1_q0), .position_z_1_q1(position_z_1_q1),
        .position_z_2_address0(position_z_2_address0), .position_z_2_address1(position_z_2_address1), .position_z_2_ce0(position_z_2_ce0), .position_z_2_ce1(position_z_2_ce1), .position_z_2_q0(position_z_2_q0), .position_z_2_q1(position_z_2_q1),
        .position_z_3_address0(position_z_3_address0), .position_z_3_address1(position_z_3_address1), .position_z_3_ce0(position_z_3_ce0), .position_z_3_ce1(position_z_3_ce1), .position_z_3_q0(position_z_3_q0), .position_z_3_q1(position_z_3_q1),
        .position_z_4_address0(position_z_4_address0), .position_z_4_address1(position_z_4_address1), .position_z_4_ce0(position_z_4_ce0), .position_z_4_ce1(position_z_4_ce1), .position_z_4_q0(position_z_4_q0), .position_z_4_q1(position_z_4_q1),
        .position_z_5_address0(position_z_5_address0), .position_z_5_address1(position_z_5_address1), .position_z_5_ce0(position_z_5_ce0), .position_z_5_ce1(position_z_5_ce1), .position_z_5_q0(position_z_5_q0), .position_z_5_q1(position_z_5_q1),
        .position_z_6_address0(position_z_6_address0), .position_z_6_address1(position_z_6_address1), .position_z_6_ce0(position_z_6_ce0), .position_z_6_ce1(position_z_6_ce1), .position_z_6_q0(position_z_6_q0), .position_z_6_q1(position_z_6_q1),
        .position_z_7_address0(position_z_7_address0), .position_z_7_address1(position_z_7_address1), .position_z_7_ce0(position_z_7_ce0), .position_z_7_ce1(position_z_7_ce1), .position_z_7_q0(position_z_7_q0), .position_z_7_q1(position_z_7_q1),

        // Force Connections
        .force_x_address0(force_x_address0), .force_x_ce0(force_x_ce0), .force_x_we0(force_x_we0), .force_x_d0(force_x_d0),
        .force_y_0_address0(force_y_0_address0), .force_y_0_ce0(force_y_0_ce0), .force_y_0_we0(force_y_0_we0), .force_y_0_d0(force_y_0_d0),
        .force_y_1_address0(force_y_1_address0), .force_y_1_ce0(force_y_1_ce0), .force_y_1_we0(force_y_1_we0), .force_y_1_d0(force_y_1_d0),
        .force_z_0_address0(force_z_0_address0), .force_z_0_ce0(force_z_0_ce0), .force_z_0_we0(force_z_0_we0), .force_z_0_d0(force_z_0_d0),
        .force_z_1_address0(force_z_1_address0), .force_z_1_ce0(force_z_1_ce0), .force_z_1_we0(force_z_1_we0), .force_z_1_d0(force_z_1_d0),
        .force_z_2_address0(force_z_2_address0), .force_z_2_ce0(force_z_2_ce0), .force_z_2_we0(force_z_2_we0), .force_z_2_d0(force_z_2_d0),
        .force_z_3_address0(force_z_3_address0), .force_z_3_ce0(force_z_3_ce0), .force_z_3_we0(force_z_3_we0), .force_z_3_d0(force_z_3_d0),
        .force_z_4_address0(force_z_4_address0), .force_z_4_ce0(force_z_4_ce0), .force_z_4_we0(force_z_4_we0), .force_z_4_d0(force_z_4_d0),
        .force_z_5_address0(force_z_5_address0), .force_z_5_ce0(force_z_5_ce0), .force_z_5_we0(force_z_5_we0), .force_z_5_d0(force_z_5_d0),
        .force_z_6_address0(force_z_6_address0), .force_z_6_ce0(force_z_6_ce0), .force_z_6_we0(force_z_6_we0), .force_z_6_d0(force_z_6_d0),
        .force_z_7_address0(force_z_7_address0), .force_z_7_ce0(force_z_7_ce0), .force_z_7_we0(force_z_7_we0), .force_z_7_d0(force_z_7_d0)
    );

    // Clock Generation
    always #(CLK_PERIOD/2) ap_clk = ~ap_clk;


    // ===================================================================
    // == 4. Memory Modeling Logic
    // ===================================================================

    // Asynchronous read logic for all input memories
    // Synchronous read logic for all input memories
    always @(posedge ap_clk) begin
        // NL Memories
        if(NL_0_ce0) NL_0_q0 <= NL_mem[0][NL_0_address0];
        if(NL_0_ce1) NL_0_q1 <= NL_mem[0][NL_0_address1];
        if(NL_1_ce0) NL_1_q0 <= NL_mem[1][NL_1_address0];
        if(NL_1_ce1) NL_1_q1 <= NL_mem[1][NL_1_address1];
        if(NL_2_ce0) NL_2_q0 <= NL_mem[2][NL_2_address0];
        if(NL_2_ce1) NL_2_q1 <= NL_mem[2][NL_2_address1];
        if(NL_3_ce0) NL_3_q0 <= NL_mem[3][NL_3_address0];
        if(NL_3_ce1) NL_3_q1 <= NL_mem[3][NL_3_address1];
        if(NL_4_ce0) NL_4_q0 <= NL_mem[4][NL_4_address0];
        if(NL_4_ce1) NL_4_q1 <= NL_mem[4][NL_4_address1];
        if(NL_5_ce0) NL_5_q0 <= NL_mem[5][NL_5_address0];
        if(NL_5_ce1) NL_5_q1 <= NL_mem[5][NL_5_address1];
        if(NL_6_ce0) NL_6_q0 <= NL_mem[6][NL_6_address0];
        if(NL_6_ce1) NL_6_q1 <= NL_mem[6][NL_6_address1];
        if(NL_7_ce0) NL_7_q0 <= NL_mem[7][NL_7_address0];
        if(NL_7_ce1) NL_7_q1 <= NL_mem[7][NL_7_address1];
        if(NL_8_ce0) NL_8_q0 <= NL_mem[8][NL_8_address0];
        if(NL_8_ce1) NL_8_q1 <= NL_mem[8][NL_8_address1];
        if(NL_9_ce0) NL_9_q0 <= NL_mem[9][NL_9_address0];
        if(NL_9_ce1) NL_9_q1 <= NL_mem[9][NL_9_address1];
        if(NL_10_ce0) NL_10_q0 <= NL_mem[10][NL_10_address0];
        if(NL_10_ce1) NL_10_q1 <= NL_mem[10][NL_10_address1];
        if(NL_11_ce0) NL_11_q0 <= NL_mem[11][NL_11_address0];
        if(NL_11_ce1) NL_11_q1 <= NL_mem[11][NL_11_address1];
        if(NL_12_ce0) NL_12_q0 <= NL_mem[12][NL_12_address0];
        if(NL_12_ce1) NL_12_q1 <= NL_mem[12][NL_12_address1];
        if(NL_13_ce0) NL_13_q0 <= NL_mem[13][NL_13_address0];
        if(NL_13_ce1) NL_13_q1 <= NL_mem[13][NL_13_address1];
        if(NL_14_ce0) NL_14_q0 <= NL_mem[14][NL_14_address0];
        if(NL_14_ce1) NL_14_q1 <= NL_mem[14][NL_14_address1];
        if(NL_15_ce0) NL_15_q0 <= NL_mem[15][NL_15_address0];
        if(NL_15_ce1) NL_15_q1 <= NL_mem[15][NL_15_address1];
        if(NL_16_ce0) NL_16_q0 <= NL_mem[16][NL_16_address0];
        if(NL_16_ce1) NL_16_q1 <= NL_mem[16][NL_16_address1];
        if(NL_17_ce0) NL_17_q0 <= NL_mem[17][NL_17_address0];
        if(NL_17_ce1) NL_17_q1 <= NL_mem[17][NL_17_address1];
        if(NL_18_ce0) NL_18_q0 <= NL_mem[18][NL_18_address0];
        if(NL_18_ce1) NL_18_q1 <= NL_mem[18][NL_18_address1];
        if(NL_19_ce0) NL_19_q0 <= NL_mem[19][NL_19_address0];
        if(NL_19_ce1) NL_19_q1 <= NL_mem[19][NL_19_address1];
        if(NL_20_ce0) NL_20_q0 <= NL_mem[20][NL_20_address0];
        if(NL_20_ce1) NL_20_q1 <= NL_mem[20][NL_20_address1];
        if(NL_21_ce0) NL_21_q0 <= NL_mem[21][NL_21_address0];
        if(NL_21_ce1) NL_21_q1 <= NL_mem[21][NL_21_address1];
        if(NL_22_ce0) NL_22_q0 <= NL_mem[22][NL_22_address0];
        if(NL_22_ce1) NL_22_q1 <= NL_mem[22][NL_22_address1];
        if(NL_23_ce0) NL_23_q0 <= NL_mem[23][NL_23_address0];
        if(NL_23_ce1) NL_23_q1 <= NL_mem[23][NL_23_address1];
        if(NL_24_ce0) NL_24_q0 <= NL_mem[24][NL_24_address0];
        if(NL_24_ce1) NL_24_q1 <= NL_mem[24][NL_24_address1];
        if(NL_25_ce0) NL_25_q0 <= NL_mem[25][NL_25_address0];
        if(NL_25_ce1) NL_25_q1 <= NL_mem[25][NL_25_address1];
        if(NL_26_ce0) NL_26_q0 <= NL_mem[26][NL_26_address0];
        if(NL_26_ce1) NL_26_q1 <= NL_mem[26][NL_26_address1];
        if(NL_27_ce0) NL_27_q0 <= NL_mem[27][NL_27_address0];
        if(NL_27_ce1) NL_27_q1 <= NL_mem[27][NL_27_address1];
        if(NL_28_ce0) NL_28_q0 <= NL_mem[28][NL_28_address0];
        if(NL_28_ce1) NL_28_q1 <= NL_mem[28][NL_28_address1];
        if(NL_29_ce0) NL_29_q0 <= NL_mem[29][NL_29_address0];
        if(NL_29_ce1) NL_29_q1 <= NL_mem[29][NL_29_address1];
        if(NL_30_ce0) NL_30_q0 <= NL_mem[30][NL_30_address0];
        if(NL_30_ce1) NL_30_q1 <= NL_mem[30][NL_30_address1];
        if(NL_31_ce0) NL_31_q0 <= NL_mem[31][NL_31_address0];
        if(NL_31_ce1) NL_31_q1 <= NL_mem[31][NL_31_address1];
        if(NL_32_ce0) NL_32_q0 <= NL_mem[32][NL_32_address0];
        if(NL_32_ce1) NL_32_q1 <= NL_mem[32][NL_32_address1];
        if(NL_33_ce0) NL_33_q0 <= NL_mem[33][NL_33_address0];
        if(NL_33_ce1) NL_33_q1 <= NL_mem[33][NL_33_address1];
        if(NL_34_ce0) NL_34_q0 <= NL_mem[34][NL_34_address0];
        if(NL_34_ce1) NL_34_q1 <= NL_mem[34][NL_34_address1];
        if(NL_35_ce0) NL_35_q0 <= NL_mem[35][NL_35_address0];
        if(NL_35_ce1) NL_35_q1 <= NL_mem[35][NL_35_address1];
        if(NL_36_ce0) NL_36_q0 <= NL_mem[36][NL_36_address0];
        if(NL_36_ce1) NL_36_q1 <= NL_mem[36][NL_36_address1];
        if(NL_37_ce0) NL_37_q0 <= NL_mem[37][NL_37_address0];
        if(NL_37_ce1) NL_37_q1 <= NL_mem[37][NL_37_address1];
        if(NL_38_ce0) NL_38_q0 <= NL_mem[38][NL_38_address0];
        if(NL_38_ce1) NL_38_q1 <= NL_mem[38][NL_38_address1];
        if(NL_39_ce0) NL_39_q0 <= NL_mem[39][NL_39_address0];
        if(NL_39_ce1) NL_39_q1 <= NL_mem[39][NL_39_address1];
        if(NL_40_ce0) NL_40_q0 <= NL_mem[40][NL_40_address0];
        if(NL_40_ce1) NL_40_q1 <= NL_mem[40][NL_40_address1];
        if(NL_41_ce0) NL_41_q0 <= NL_mem[41][NL_41_address0];
        if(NL_41_ce1) NL_41_q1 <= NL_mem[41][NL_41_address1];
        if(NL_42_ce0) NL_42_q0 <= NL_mem[42][NL_42_address0];
        if(NL_42_ce1) NL_42_q1 <= NL_mem[42][NL_42_address1];
        if(NL_43_ce0) NL_43_q0 <= NL_mem[43][NL_43_address0];
        if(NL_43_ce1) NL_43_q1 <= NL_mem[43][NL_43_address1];
        if(NL_44_ce0) NL_44_q0 <= NL_mem[44][NL_44_address0];
        if(NL_44_ce1) NL_44_q1 <= NL_mem[44][NL_44_address1];
        if(NL_45_ce0) NL_45_q0 <= NL_mem[45][NL_45_address0];
        if(NL_45_ce1) NL_45_q1 <= NL_mem[45][NL_45_address1];
        if(NL_46_ce0) NL_46_q0 <= NL_mem[46][NL_46_address0];
        if(NL_46_ce1) NL_46_q1 <= NL_mem[46][NL_46_address1];
        if(NL_47_ce0) NL_47_q0 <= NL_mem[47][NL_47_address0];
        if(NL_47_ce1) NL_47_q1 <= NL_mem[47][NL_47_address1];
        if(NL_48_ce0) NL_48_q0 <= NL_mem[48][NL_48_address0];
        if(NL_48_ce1) NL_48_q1 <= NL_mem[48][NL_48_address1];
        if(NL_49_ce0) NL_49_q0 <= NL_mem[49][NL_49_address0];
        if(NL_49_ce1) NL_49_q1 <= NL_mem[49][NL_49_address1];
        if(NL_50_ce0) NL_50_q0 <= NL_mem[50][NL_50_address0];
        if(NL_50_ce1) NL_50_q1 <= NL_mem[50][NL_50_address1];
        if(NL_51_ce0) NL_51_q0 <= NL_mem[51][NL_51_address0];
        if(NL_51_ce1) NL_51_q1 <= NL_mem[51][NL_51_address1];
        if(NL_52_ce0) NL_52_q0 <= NL_mem[52][NL_52_address0];
        if(NL_52_ce1) NL_52_q1 <= NL_mem[52][NL_52_address1];
        if(NL_53_ce0) NL_53_q0 <= NL_mem[53][NL_53_address0];
        if(NL_53_ce1) NL_53_q1 <= NL_mem[53][NL_53_address1];
        if(NL_54_ce0) NL_54_q0 <= NL_mem[54][NL_54_address0];
        if(NL_54_ce1) NL_54_q1 <= NL_mem[54][NL_54_address1];
        if(NL_55_ce0) NL_55_q0 <= NL_mem[55][NL_55_address0];
        if(NL_55_ce1) NL_55_q1 <= NL_mem[55][NL_55_address1];
        if(NL_56_ce0) NL_56_q0 <= NL_mem[56][NL_56_address0];
        if(NL_56_ce1) NL_56_q1 <= NL_mem[56][NL_56_address1];
        if(NL_57_ce0) NL_57_q0 <= NL_mem[57][NL_57_address0];
        if(NL_57_ce1) NL_57_q1 <= NL_mem[57][NL_57_address1];
        if(NL_58_ce0) NL_58_q0 <= NL_mem[58][NL_58_address0];
        if(NL_58_ce1) NL_58_q1 <= NL_mem[58][NL_58_address1];
        if(NL_59_ce0) NL_59_q0 <= NL_mem[59][NL_59_address0];
        if(NL_59_ce1) NL_59_q1 <= NL_mem[59][NL_59_address1];
        if(NL_60_ce0) NL_60_q0 <= NL_mem[60][NL_60_address0];
        if(NL_60_ce1) NL_60_q1 <= NL_mem[60][NL_60_address1];
        if(NL_61_ce0) NL_61_q0 <= NL_mem[61][NL_61_address0];
        if(NL_61_ce1) NL_61_q1 <= NL_mem[61][NL_61_address1];
        if(NL_62_ce0) NL_62_q0 <= NL_mem[62][NL_62_address0];
        if(NL_62_ce1) NL_62_q1 <= NL_mem[62][NL_62_address1];
        if(NL_63_ce0) NL_63_q0 <= NL_mem[63][NL_63_address0];
        if(NL_63_ce1) NL_63_q1 <= NL_mem[63][NL_63_address1];
        if(NL_64_ce0) NL_64_q0 <= NL_mem[64][NL_64_address0];
        if(NL_64_ce1) NL_64_q1 <= NL_mem[64][NL_64_address1];
        if(NL_65_ce0) NL_65_q0 <= NL_mem[65][NL_65_address0];
        if(NL_65_ce1) NL_65_q1 <= NL_mem[65][NL_65_address1];
        if(NL_66_ce0) NL_66_q0 <= NL_mem[66][NL_66_address0];
        if(NL_66_ce1) NL_66_q1 <= NL_mem[66][NL_66_address1];
        if(NL_67_ce0) NL_67_q0 <= NL_mem[67][NL_67_address0];
        if(NL_67_ce1) NL_67_q1 <= NL_mem[67][NL_67_address1];
        if(NL_68_ce0) NL_68_q0 <= NL_mem[68][NL_68_address0];
        if(NL_68_ce1) NL_68_q1 <= NL_mem[68][NL_68_address1];
        if(NL_69_ce0) NL_69_q0 <= NL_mem[69][NL_69_address0];
        if(NL_69_ce1) NL_69_q1 <= NL_mem[69][NL_69_address1];
        if(NL_70_ce0) NL_70_q0 <= NL_mem[70][NL_70_address0];
        if(NL_70_ce1) NL_70_q1 <= NL_mem[70][NL_70_address1];
        if(NL_71_ce0) NL_71_q0 <= NL_mem[71][NL_71_address0];
        if(NL_71_ce1) NL_71_q1 <= NL_mem[71][NL_71_address1];
        if(NL_72_ce0) NL_72_q0 <= NL_mem[72][NL_72_address0];
        if(NL_72_ce1) NL_72_q1 <= NL_mem[72][NL_72_address1];
        if(NL_73_ce0) NL_73_q0 <= NL_mem[73][NL_73_address0];
        if(NL_73_ce1) NL_73_q1 <= NL_mem[73][NL_73_address1];
        if(NL_74_ce0) NL_74_q0 <= NL_mem[74][NL_74_address0];
        if(NL_74_ce1) NL_74_q1 <= NL_mem[74][NL_74_address1];
        if(NL_75_ce0) NL_75_q0 <= NL_mem[75][NL_75_address0];
        if(NL_75_ce1) NL_75_q1 <= NL_mem[75][NL_75_address1];
        if(NL_76_ce0) NL_76_q0 <= NL_mem[76][NL_76_address0];
        if(NL_76_ce1) NL_76_q1 <= NL_mem[76][NL_76_address1];
        if(NL_77_ce0) NL_77_q0 <= NL_mem[77][NL_77_address0];
        if(NL_77_ce1) NL_77_q1 <= NL_mem[77][NL_77_address1];
        if(NL_78_ce0) NL_78_q0 <= NL_mem[78][NL_78_address0];
        if(NL_78_ce1) NL_78_q1 <= NL_mem[78][NL_78_address1];
        if(NL_79_ce0) NL_79_q0 <= NL_mem[79][NL_79_address0];
        if(NL_79_ce1) NL_79_q1 <= NL_mem[79][NL_79_address1];
        if(NL_80_ce0) NL_80_q0 <= NL_mem[80][NL_80_address0];
        if(NL_80_ce1) NL_80_q1 <= NL_mem[80][NL_80_address1];
        if(NL_81_ce0) NL_81_q0 <= NL_mem[81][NL_81_address0];
        if(NL_81_ce1) NL_81_q1 <= NL_mem[81][NL_81_address1];
        if(NL_82_ce0) NL_82_q0 <= NL_mem[82][NL_82_address0];
        if(NL_82_ce1) NL_82_q1 <= NL_mem[82][NL_82_address1];
        if(NL_83_ce0) NL_83_q0 <= NL_mem[83][NL_83_address0];
        if(NL_83_ce1) NL_83_q1 <= NL_mem[83][NL_83_address1];
        if(NL_84_ce0) NL_84_q0 <= NL_mem[84][NL_84_address0];
        if(NL_84_ce1) NL_84_q1 <= NL_mem[84][NL_84_address1];
        if(NL_85_ce0) NL_85_q0 <= NL_mem[85][NL_85_address0];
        if(NL_85_ce1) NL_85_q1 <= NL_mem[85][NL_85_address1];
        if(NL_86_ce0) NL_86_q0 <= NL_mem[86][NL_86_address0];
        if(NL_86_ce1) NL_86_q1 <= NL_mem[86][NL_86_address1];
        if(NL_87_ce0) NL_87_q0 <= NL_mem[87][NL_87_address0];
        if(NL_87_ce1) NL_87_q1 <= NL_mem[87][NL_87_address1];
        if(NL_88_ce0) NL_88_q0 <= NL_mem[88][NL_88_address0];
        if(NL_88_ce1) NL_88_q1 <= NL_mem[88][NL_88_address1];
        if(NL_89_ce0) NL_89_q0 <= NL_mem[89][NL_89_address0];
        if(NL_89_ce1) NL_89_q1 <= NL_mem[89][NL_89_address1];
        if(NL_90_ce0) NL_90_q0 <= NL_mem[90][NL_90_address0];
        if(NL_90_ce1) NL_90_q1 <= NL_mem[90][NL_90_address1];
        if(NL_91_ce0) NL_91_q0 <= NL_mem[91][NL_91_address0];
        if(NL_91_ce1) NL_91_q1 <= NL_mem[91][NL_91_address1];
        if(NL_92_ce0) NL_92_q0 <= NL_mem[92][NL_92_address0];
        if(NL_92_ce1) NL_92_q1 <= NL_mem[92][NL_92_address1];
        if(NL_93_ce0) NL_93_q0 <= NL_mem[93][NL_93_address0];
        if(NL_93_ce1) NL_93_q1 <= NL_mem[93][NL_93_address1];
        if(NL_94_ce0) NL_94_q0 <= NL_mem[94][NL_94_address0];
        if(NL_94_ce1) NL_94_q1 <= NL_mem[94][NL_94_address1];
        if(NL_95_ce0) NL_95_q0 <= NL_mem[95][NL_95_address0];
        if(NL_95_ce1) NL_95_q1 <= NL_mem[95][NL_95_address1];
        if(NL_96_ce0) NL_96_q0 <= NL_mem[96][NL_96_address0];
        if(NL_96_ce1) NL_96_q1 <= NL_mem[96][NL_96_address1];
        if(NL_97_ce0) NL_97_q0 <= NL_mem[97][NL_97_address0];
        if(NL_97_ce1) NL_97_q1 <= NL_mem[97][NL_97_address1];
        if(NL_98_ce0) NL_98_q0 <= NL_mem[98][NL_98_address0];
        if(NL_98_ce1) NL_98_q1 <= NL_mem[98][NL_98_address1];
        if(NL_99_ce0) NL_99_q0 <= NL_mem[99][NL_99_address0];
        if(NL_99_ce1) NL_99_q1 <= NL_mem[99][NL_99_address1];
        if(NL_100_ce0) NL_100_q0 <= NL_mem[100][NL_100_address0];
        if(NL_100_ce1) NL_100_q1 <= NL_mem[100][NL_100_address1];
        if(NL_101_ce0) NL_101_q0 <= NL_mem[101][NL_101_address0];
        if(NL_101_ce1) NL_101_q1 <= NL_mem[101][NL_101_address1];
        if(NL_102_ce0) NL_102_q0 <= NL_mem[102][NL_102_address0];
        if(NL_102_ce1) NL_102_q1 <= NL_mem[102][NL_102_address1];
        if(NL_103_ce0) NL_103_q0 <= NL_mem[103][NL_103_address0];
        if(NL_103_ce1) NL_103_q1 <= NL_mem[103][NL_103_address1];
        if(NL_104_ce0) NL_104_q0 <= NL_mem[104][NL_104_address0];
        if(NL_104_ce1) NL_104_q1 <= NL_mem[104][NL_104_address1];
        if(NL_105_ce0) NL_105_q0 <= NL_mem[105][NL_105_address0];
        if(NL_105_ce1) NL_105_q1 <= NL_mem[105][NL_105_address1];
        if(NL_106_ce0) NL_106_q0 <= NL_mem[106][NL_106_address0];
        if(NL_106_ce1) NL_106_q1 <= NL_mem[106][NL_106_address1];
        if(NL_107_ce0) NL_107_q0 <= NL_mem[107][NL_107_address0];
        if(NL_107_ce1) NL_107_q1 <= NL_mem[107][NL_107_address1];
        if(NL_108_ce0) NL_108_q0 <= NL_mem[108][NL_108_address0];
        if(NL_108_ce1) NL_108_q1 <= NL_mem[108][NL_108_address1];
        if(NL_109_ce0) NL_109_q0 <= NL_mem[109][NL_109_address0];
        if(NL_109_ce1) NL_109_q1 <= NL_mem[109][NL_109_address1];
        if(NL_110_ce0) NL_110_q0 <= NL_mem[110][NL_110_address0];
        if(NL_110_ce1) NL_110_q1 <= NL_mem[110][NL_110_address1];
        if(NL_111_ce0) NL_111_q0 <= NL_mem[111][NL_111_address0];
        if(NL_111_ce1) NL_111_q1 <= NL_mem[111][NL_111_address1];
        if(NL_112_ce0) NL_112_q0 <= NL_mem[112][NL_112_address0];
        if(NL_112_ce1) NL_112_q1 <= NL_mem[112][NL_112_address1];
        if(NL_113_ce0) NL_113_q0 <= NL_mem[113][NL_113_address0];
        if(NL_113_ce1) NL_113_q1 <= NL_mem[113][NL_113_address1];
        if(NL_114_ce0) NL_114_q0 <= NL_mem[114][NL_114_address0];
        if(NL_114_ce1) NL_114_q1 <= NL_mem[114][NL_114_address1];
        if(NL_115_ce0) NL_115_q0 <= NL_mem[115][NL_115_address0];
        if(NL_115_ce1) NL_115_q1 <= NL_mem[115][NL_115_address1];
        if(NL_116_ce0) NL_116_q0 <= NL_mem[116][NL_116_address0];
        if(NL_116_ce1) NL_116_q1 <= NL_mem[116][NL_116_address1];
        if(NL_117_ce0) NL_117_q0 <= NL_mem[117][NL_117_address0];
        if(NL_117_ce1) NL_117_q1 <= NL_mem[117][NL_117_address1];
        if(NL_118_ce0) NL_118_q0 <= NL_mem[118][NL_118_address0];
        if(NL_118_ce1) NL_118_q1 <= NL_mem[118][NL_118_address1];
        if(NL_119_ce0) NL_119_q0 <= NL_mem[119][NL_119_address0];
        if(NL_119_ce1) NL_119_q1 <= NL_mem[119][NL_119_address1];
        if(NL_120_ce0) NL_120_q0 <= NL_mem[120][NL_120_address0];
        if(NL_120_ce1) NL_120_q1 <= NL_mem[120][NL_120_address1];
        if(NL_121_ce0) NL_121_q0 <= NL_mem[121][NL_121_address0];
        if(NL_121_ce1) NL_121_q1 <= NL_mem[121][NL_121_address1];
        if(NL_122_ce0) NL_122_q0 <= NL_mem[122][NL_122_address0];
        if(NL_122_ce1) NL_122_q1 <= NL_mem[122][NL_122_address1];
        if(NL_123_ce0) NL_123_q0 <= NL_mem[123][NL_123_address0];
        if(NL_123_ce1) NL_123_q1 <= NL_mem[123][NL_123_address1];
        if(NL_124_ce0) NL_124_q0 <= NL_mem[124][NL_124_address0];
        if(NL_124_ce1) NL_124_q1 <= NL_mem[124][NL_124_address1];
        if(NL_125_ce0) NL_125_q0 <= NL_mem[125][NL_125_address0];
        if(NL_125_ce1) NL_125_q1 <= NL_mem[125][NL_125_address1];
        if(NL_126_ce0) NL_126_q0 <= NL_mem[126][NL_126_address0];
        if(NL_126_ce1) NL_126_q1 <= NL_mem[126][NL_126_address1];
        if(NL_127_ce0) NL_127_q0 <= NL_mem[127][NL_127_address0];
        if(NL_127_ce1) NL_127_q1 <= NL_mem[127][NL_127_address1];
        
        // Position_X Memories
        if(position_x_0_ce0) position_x_0_q0 <= position_x_mem[0][position_x_0_address0];
        if(position_x_0_ce1) position_x_0_q1 <= position_x_mem[0][position_x_0_address1];
        if(position_x_1_ce0) position_x_1_q0 <= position_x_mem[1][position_x_1_address0];
        if(position_x_1_ce1) position_x_1_q1 <= position_x_mem[1][position_x_1_address1];
        if(position_x_2_ce0) position_x_2_q0 <= position_x_mem[2][position_x_2_address0];
        if(position_x_2_ce1) position_x_2_q1 <= position_x_mem[2][position_x_2_address1];
        if(position_x_3_ce0) position_x_3_q0 <= position_x_mem[3][position_x_3_address0];
        if(position_x_3_ce1) position_x_3_q1 <= position_x_mem[3][position_x_3_address1];
        
        // Position_Y Memories
        if(position_y_0_ce0) position_y_0_q0 <= position_y_mem[0][position_y_0_address0];
        if(position_y_0_ce1) position_y_0_q1 <= position_y_mem[0][position_y_0_address1];
        if(position_y_1_ce0) position_y_1_q0 <= position_y_mem[1][position_y_1_address0];
        if(position_y_1_ce1) position_y_1_q1 <= position_y_mem[1][position_y_1_address1];
        if(position_y_2_ce0) position_y_2_q0 <= position_y_mem[2][position_y_2_address0];
        if(position_y_2_ce1) position_y_2_q1 <= position_y_mem[2][position_y_2_address1];
        if(position_y_3_ce0) position_y_3_q0 <= position_y_mem[3][position_y_3_address0];
        if(position_y_3_ce1) position_y_3_q1 <= position_y_mem[3][position_y_3_address1];
        if(position_y_4_ce0) position_y_4_q0 <= position_y_mem[4][position_y_4_address0];
        if(position_y_4_ce1) position_y_4_q1 <= position_y_mem[4][position_y_4_address1];
        if(position_y_5_ce0) position_y_5_q0 <= position_y_mem[5][position_y_5_address0];
        if(position_y_5_ce1) position_y_5_q1 <= position_y_mem[5][position_y_5_address1];
        if(position_y_6_ce0) position_y_6_q0 <= position_y_mem[6][position_y_6_address0];
        if(position_y_6_ce1) position_y_6_q1 <= position_y_mem[6][position_y_6_address1];
        if(position_y_7_ce0) position_y_7_q0 <= position_y_mem[7][position_y_7_address0];
        if(position_y_7_ce1) position_y_7_q1 <= position_y_mem[7][position_y_7_address1];

        // Position_Z Memories
        if(position_z_0_ce0) position_z_0_q0 <= position_z_mem[0][position_z_0_address0];
        if(position_z_0_ce1) position_z_0_q1 <= position_z_mem[0][position_z_0_address1];
        if(position_z_1_ce0) position_z_1_q0 <= position_z_mem[1][position_z_1_address0];
        if(position_z_1_ce1) position_z_1_q1 <= position_z_mem[1][position_z_1_address1];
        if(position_z_2_ce0) position_z_2_q0 <= position_z_mem[2][position_z_2_address0];
        if(position_z_2_ce1) position_z_2_q1 <= position_z_mem[2][position_z_2_address1];
        if(position_z_3_ce0) position_z_3_q0 <= position_z_mem[3][position_z_3_address0];
        if(position_z_3_ce1) position_z_3_q1 <= position_z_mem[3][position_z_3_address1];
        if(position_z_4_ce0) position_z_4_q0 <= position_z_mem[4][position_z_4_address0];
        if(position_z_4_ce1) position_z_4_q1 <= position_z_mem[4][position_z_4_address1];
        if(position_z_5_ce0) position_z_5_q0 <= position_z_mem[5][position_z_5_address0];
        if(position_z_5_ce1) position_z_5_q1 <= position_z_mem[5][position_z_5_address1];
        if(position_z_6_ce0) position_z_6_q0 <= position_z_mem[6][position_z_6_address0];
        if(position_z_6_ce1) position_z_6_q1 <= position_z_mem[6][position_z_6_address1];
        if(position_z_7_ce0) position_z_7_q0 <= position_z_mem[7][position_z_7_address0];
        if(position_z_7_ce1) position_z_7_q1 <= position_z_mem[7][position_z_7_address1];
    end
    
    // Synchronous write logic for all output memories
    always @(posedge ap_clk) begin
        if (force_x_ce0 && force_x_we0) force_x_mem[force_x_address0] <= force_x_d0;
        
        if (force_y_0_ce0 && force_y_0_we0) force_y_mem[0][force_y_0_address0] <= force_y_0_d0;
        if (force_y_1_ce0 && force_y_1_we0) force_y_mem[1][force_y_1_address0] <= force_y_1_d0;

        if (force_z_0_ce0 && force_z_0_we0) force_z_mem[0][force_z_0_address0] <= force_z_0_d0;
        if (force_z_1_ce0 && force_z_1_we0) force_z_mem[1][force_z_1_address0] <= force_z_1_d0;
        if (force_z_2_ce0 && force_z_2_we0) force_z_mem[2][force_z_2_address0] <= force_z_2_d0;
        if (force_z_3_ce0 && force_z_3_we0) force_z_mem[3][force_z_3_address0] <= force_z_3_d0;
        if (force_z_4_ce0 && force_z_4_we0) force_z_mem[4][force_z_4_address0] <= force_z_4_d0;
        if (force_z_5_ce0 && force_z_5_we0) force_z_mem[5][force_z_5_address0] <= force_z_5_d0;
        if (force_z_6_ce0 && force_z_6_we0) force_z_mem[6][force_z_6_address0] <= force_z_6_d0;
        if (force_z_7_ce0 && force_z_7_we0) force_z_mem[7][force_z_7_address0] <= force_z_7_d0;
    end

    // ===================================================================
    // == 5. Main Simulation Sequence
    // ===================================================================
    
    initial begin
        // Initialize signals
        ap_clk = 0;
        ap_rst = 1;
        ap_ctrl_start = 0;

        init_mem;

        // Apply Reset
        #20000;
        ap_rst = 0;
        
        // Wait for DUT to be ready and then start
        wait (ap_ctrl_ready == 1);
        @(posedge ap_clk);
        ap_ctrl_start = 1;
        @(posedge ap_clk);
        ap_ctrl_start = 0;

        // Wait for the DUT to finish
        wait (ap_ctrl_done == 1);
        $display("Kernel processing finished.");

        // Display results from output memories
        display_results;

        // End simulation
        #10000;
        $finish;
    end
    
    task init_mem;
        // Initialize all memories to a known state
        integer i,j;
        begin
            for (i=0; i<128; i=i+1) for(j=0; j<32; j=j+1) NL_mem[i][j] = i*32+j;
            for (i=0; i<4; i=i+1) for(j=0; j<64; j=j+1) position_x_mem[i][j] = i*64+j;
            for (i=0; i<8; i=i+1) for(j=0; j<32; j=j+1) position_y_mem[i][j] = i*32+j;
            for (i=0; i<8; i=i+1) for(j=0; j<32; j=j+1) position_z_mem[i][j] = i*32+j;
            for (i=0; i<256; i=i+1) force_x_mem[i] = 0;
            for (i=0; i<2; i=i+1) for(j=0; j<128; j=j+1) force_y_mem[i][j] = 0;
            for (i=0; i<8; i=i+1) for(j=0; j<32; j=j+1) force_z_mem[i][j] = 0;
        end
    endtask

    task display_results;
        integer i, j;
        begin
            $display("\nforce_x_mem Contents:");
            for (i = 0; i < 256; i = i + 1) begin
                if (force_x_mem[i] !== 0) // Display only written values
                    $display("force_x_mem[%0d] = %h", i, force_x_mem[i]);
            end
            
            $display("\nforce_y_mem Contents:");
            for (i=0; i<2; i=i+1) begin
                for (j=0; j<128; j=j+1) begin
                    if (force_y_mem[i][j] !== 0)
                        $display("force_y_mem[%0d][%0d] = %h", i, j, force_y_mem[i][j]);
                end
            end
            
            $display("\nforce_z_mem Contents:");
            for (i=0; i<8; i=i+1) begin
                for (j=0; j<32; j=j+1) begin
                    if (force_z_mem[i][j] !== 0)
                        $display("force_z_mem[%0d][%0d] = %h", i, j, force_z_mem[i][j]);
                end
            end
        end
    endtask

endmodule


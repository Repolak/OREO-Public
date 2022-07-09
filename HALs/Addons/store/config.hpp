/*
	Macro: ERROR_WITH_TITLE()

	Parameters:
	0: CLASSNAME - Classname of item
	1: PRICE - Default item price
	2: STOCK - Default item stock
__________________________________________________________________*/
#define ITEM(CLASSNAME, PRICE, STOCK)\
	class CLASSNAME {\
		price = PRICE;\
		stock = STOCK;\
	};

class cfgHALsStore {
	containerTypes[] = {"LandVehicle","NATO_Box_Base","ReammoBox_F","Box_NATO_Equip_F"};
	containerRadius = 0;
	currencySymbol = "Credits";
	sellFactor = 0.9;
	debug = 1;

	class categories {

		class weeklySpecial {
			displayName = "-Weekly Specials-";
			#define STOCKNUM 10

			ITEM(G_Spectacles_Tinted,15,STOCKNUM);
			ITEM(VSM_Balaclava_Black,15,STOCKNUM);
			ITEM(murshun_cigs_cigpack,3,STOCKNUM);
			ITEM(murshun_cigs_matches,1,STOCKNUM);
		};

		class generalAcc {
			displayName = "General - Accessories";
			#define STOCKNUM 100

			ITEM(tier1_socom556_2_black,1,STOCKNUM);
			ITEM(tier1_socom556_2_mini_black,2,STOCKNUM);
			ITEM(rhsusf_acc_grip2,2,STOCKNUM);
			ITEM(rhsusf_acc_kac_grip,1,STOCKNUM);
			ITEM(rhsusf_acc_rvg_blk,2,STOCKNUM);
			ITEM(rhsusf_acc_anpeq15_bk, 2, STOCKNUM);
			ITEM(rhsusf_acc_anpeq15_bk_top, 2, STOCKNUM);
			ITEM(rhsusf_acc_M952v,1,STOCKNUM);
		};

		class generalOptic {
			displayName = "General - Optics";
			#define STOCKNUM 100

			ITEM(rhsusf_acc_eotech_xps3, 2, STOCKNUM);
			ITEM(rhsusf_acc_t1_high, 3, STOCKNUM);
			ITEM(rhsusf_acc_t1_low, 3, STOCKNUM);
			ITEM(rhsusf_acc_acog, 4, STOCKNUM);
			ITEM(rhsusf_acc_su230, 5, STOCKNUM);
			ITEM(rhsusf_acc_su230_c, 5, STOCKNUM);
			ITEM(rhsusf_acc_su230_mrds, 6, STOCKNUM);
			ITEM(rhsusf_acc_su230_mrds_c, 6, STOCKNUM);
			ITEM(rhsusf_acc_acog_rmr, 5, STOCKNUM);
			ITEM(rhsusf_acc_compm4, 2, STOCKNUM);
			ITEM(rhsusf_acc_g33_xps3,5,STOCKNUM);
		};

		class generalGear {
			displayName = "General - Gear";
			#define STOCKNUM 100

			ITEM(alpha_cap_mc,3,STOCKNUM);
			ITEM(alpha_cap_blk,3,STOCKNUM);
			ITEM(shemagh_looseod,3,STOCKNUM);
			ITEM(shemagh2_goggclr_od,6,STOCKNUM);
			ITEM(shemagh2_goggblk_od,6,STOCKNUM);
			ITEM(VSM_FaceMask_Black,5,STOCKNUM);
			ITEM(VSM_Peltor_OD_glasses,4,STOCKNUM);
			ITEM(rhs_googles_black,1,STOCKNUM);
			ITEM(rhsusf_oakley_goggles_blk,2,STOCKNUM);
			ITEM(VSM_Beanie_Black,4,STOCKNUM);
			ITEM(VSM_Beanie_OD,4,STOCKNUM);
			ITEM(VSM_BackwardsHat_Peltor_Black,5,STOCKNUM);
			ITEM(VSM_BackwardsHat_Peltor_OD,5,STOCKNUM);
			ITEM(VSM_Multicam_Boonie,0,STOCKNUM);
			ITEM(tfa_Carryall_mc,7,STOCKNUM);
		};

		class generalOther {
			displayName = "General - Other";
			#define STOCKNUM 100

			ITEM(TFAR_anprc152,0,STOCKNUM);
			ITEM(VEM_commsCard,0,STOCKNUM);
		};

		class UTHelmets {
			displayName = "Opscore - UT options";
			#define STOCKNUM 100

			ITEM(Maritime_comtacIII6, 2, STOCKNUM);
			ITEM(Maritime_comtacIII12, 2, STOCKNUM);
			ITEM(Maritime_comtacIII18, 2, STOCKNUM);
			ITEM(Maritime_comtacIII18322_manta, 2, STOCKNUM);
			ITEM(Maritime_comtacIII184322_manta, 2, STOCKNUM);
		};

		class ODCHelmets {
			displayName = "Opscore - OD Cover options";
			#define STOCKNUM 100

			ITEM(Maritime_Cover_comtacIII6, 2, STOCKNUM);
			ITEM(Maritime_Cover_comtacIII12, 2, STOCKNUM);
			ITEM(Maritime_Cover_comtacIII18, 2, STOCKNUM);
			ITEM(Maritime_Cover_comtacIII18322_manta, 2, STOCKNUM);
			ITEM(Maritime_Cover_comtacIII184322_manta, 2, STOCKNUM);
		};


		class MCHelmets {
			displayName = "Opscore - MC Cover options";
			#define STOCKNUM 100

			ITEM(Maritime_Cover_comtacIII3, 2, STOCKNUM);
			ITEM(Maritime_Cover_comtacIII9, 2, STOCKNUM);
			ITEM(Maritime_Cover_comtacIII15, 2, STOCKNUM);
			ITEM(Maritime_Cover_comtacIII15354_manta, 2, STOCKNUM);
			ITEM(Maritime_Cover_comtacIII153654_manta, 2, STOCKNUM);
		};


		class Riflemen {
				displayName = "Role - Riflemen";
				#define STOCKNUM 100

				ITEM(rhs_weap_mk18_bk, 7, STOCKNUM);
				ITEM(rhs_weap_mk18_KAC, 7, STOCKNUM);
				ITEM(rhs_weap_mk18_KAC_bk, 8, STOCKNUM);
				ITEM(rhs_weap_m4a1_blockII, 10, STOCKNUM);
				ITEM(rhs_weap_m4a1_blockII_KAC, 11, STOCKNUM);
		};

		class ARifle {
			displayName = "Role - Automatic Riflemen";
			#define STOCKNUM 100

			ITEM(rhs_weap_m249_pip, 0, STOCKNUM);
			ITEM(rhs_weap_m249_light_S, 4, STOCKNUM);
			ITEM(rhs_weap_m249_pip_S_para, 4, STOCKNUM);
			ITEM(rhsusf_acc_saw_lw_bipod, 2, STOCKNUM);
			ITEM(rhsusf_acc_grip4, 1, STOCKNUM);
			ITEM(rhsusf_acc_grip1, 4, STOCKNUM);
			ITEM(rhsusf_acc_grip4_bipod, 3, STOCKNUM);
			ITEM(tier1_saw_bipod_kac, 4, STOCKNUM);
			ITEM(rhsusf_acc_elcan,3,STOCKNUM);
		};

		class Marksman {
			displayName = "Role - Designated Marksman";
			#define STOCKNUM 100

			ITEM(rhs_weap_m16a4_IMOD, 4, STOCKNUM);
			ITEM(rhs_weap_m14ebrri, 10, STOCKNUM);
			ITEM(rhsusf_acc_harris_bipod, 4, STOCKNUM);
			ITEM(rhsusf_acc_aac_m14dcqd_silencer, 0, STOCKNUM);
			ITEM(optic_ams, 4, STOCKNUM);
		};

		class SRT {
			displayName = "Special Reaction Team";
			#define STOCKNUM 69

			ITEM(Tier1_HK416D10_RAHG_CTR, 6, STOCKNUM);
			ITEM(Tier1_HK416D10_RAHG_LMT, 6, STOCKNUM);
			ITEM(rhs_weap_M107, 20, STOCKNUM);
			ITEM(rhs_weap_XM2010, 13, STOCKNUM);
			ITEM(rhs_weap_sr25_ec, 12, STOCKNUM);
			ITEM(rhs_weap_sr25, 11, STOCKNUM);
			ITEM(rhs_weap_mk17_STD, 7, STOCKNUM);
			ITEM(rhs_weap_mk17_CQC, 8, STOCKNUM);
			ITEM(rhsusf_weap_MP7A2, 8, STOCKNUM);
			ITEM(rhs_weap_M320,5,STOCKNUM);
			ITEM(tier1_kac_556_qdc_black, 1, STOCKNUM);
			ITEM(tier1_kac_556_qdc_cqb_black,2,STOCKNUM);
			ITEM(rhsusf_acc_rotex_mp7, 1, STOCKNUM);
			ITEM(tier1_razor_gen2_16_geissele_docter, 7, STOCKNUM);
			ITEM(gpn18,14,STOCKNUM);
			ITEM(VSM_balaclava2_Black,5,STOCKNUM);
			ITEM(UK3CB_B_Hiker,4,STOCKNUM);
			ITEM(vss_06_BLK,3,STOCKNUM);
			ITEM(milgp_h_cap_backwards_01_RGR,3,STOCKNUM);
			ITEM(mgsr_headbag,0,STOCKNUM);
			ITEM(Tier1_M110k5_65mm,0,STOCKNUM);
			ITEM(blue_kitbag_a,0,STOCKNUM);
			ITEM(blue_kitbag_b,0,STOCKNUM);
			ITEM(blue_kitbag_c,0,STOCKNUM);
			ITEM(red_kitbag_a,0,STOCKNUM);
			ITEM(red_kitbag_b,0,STOCKNUM);
			ITEM(red_kitbag_c,0,STOCKNUM);
			ITEM(green_kitbag_a,0,STOCKNUM);
			ITEM(green_kitbag_b,0,STOCKNUM);
			ITEM(green_kitbag_c,0,STOCKNUM);
			ITEM(orange_kitbag_a,0,STOCKNUM);
			ITEM(orange_kitbag_b,0,STOCKNUM);
			ITEM(orange_kitbag_c,0,STOCKNUM);
			ITEM(tier1_razor_gen3_110_geissele_docter,0,STOCKNUM);
			ITEM(tier1_kac_762_qdc_tan,0,STOCKNUM);
			ITEM(tier1_harris_bipod_kac_mlok_black,0,STOCKNUM);
			ITEM(tier1_urx4_la5_side,0,STOCKNUM);
			ITEM(Tier1_MK46_Mod0_Para_Desert,0,STOCKNUM);
			ITEM(tier_1_socom556_de,0,STOCKNUM);
			ITEM(TFAR_anprc152,0,STOCKNUM);
		};
	};
	class stores {

		class vics {
			displayName = "Post Exchange";
			categories[] = {"generalOther","generalAcc","generalGear","generalOptic","weeklySpecial"};
		};

		class srtStore {
			displayName = "SRT Shop";
			categories[] = {"srt"};
		};
	};
};

/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/TFG/TFG/VHDL/Evita_conflictos/TB_modulo.vhd";



static void work_a_0462189711_2372691052_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    int64 t7;
    int64 t8;

LAB0:    t1 = (t0 + 3272U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(88, ng0);
    t2 = (t0 + 3904);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(89, ng0);
    t2 = (t0 + 2288U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (t7 / 2);
    t2 = (t0 + 3080);
    xsi_process_wait(t2, t8);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(90, ng0);
    t2 = (t0 + 3904);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(91, ng0);
    t2 = (t0 + 2288U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (t7 / 2);
    t2 = (t0 + 3080);
    xsi_process_wait(t2, t8);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    goto LAB2;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

}

static void work_a_0462189711_2372691052_p_1(char *t0)
{
    char *t1;
    char *t2;
    int64 t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    int64 t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    unsigned char t21;
    unsigned int t22;
    unsigned char t23;

LAB0:    t1 = (t0 + 3520U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(99, ng0);
    t3 = (100 * 1000LL);
    t2 = (t0 + 3328);
    xsi_process_wait(t2, t3);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(100, ng0);
    t2 = (t0 + 3968);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(101, ng0);
    t2 = (t0 + 2288U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t8 = (t3 * 10);
    t2 = (t0 + 3328);
    xsi_process_wait(t2, t8);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    xsi_set_current_line(102, ng0);
    t2 = (t0 + 3968);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(108, ng0);
    t2 = xsi_get_transient_memory(10U);
    memset(t2, 0, 10U);
    t4 = t2;
    t5 = (t0 + 6488);
    memcpy(t4, t5, 2U);
    t4 = (t4 + 2U);
    t7 = (t0 + 6490);
    memcpy(t4, t7, 2U);
    t4 = (t4 + 2U);
    t10 = (t0 + 6492);
    memcpy(t4, t10, 2U);
    t4 = (t4 + 2U);
    t12 = (t0 + 6494);
    memcpy(t4, t12, 2U);
    t4 = (t4 + 2U);
    t14 = (t0 + 6496);
    memcpy(t4, t14, 2U);
    t16 = (t0 + 4032);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    memcpy(t20, t2, 10U);
    xsi_driver_first_trans_fast(t16);
    xsi_set_current_line(109, ng0);
    t2 = (t0 + 4096);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(110, ng0);
    t2 = (t0 + 2288U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 3328);
    xsi_process_wait(t2, t3);

LAB14:    *((char **)t1) = &&LAB15;
    goto LAB1;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

LAB12:    xsi_set_current_line(112, ng0);
    t2 = (t0 + 1672U);
    t4 = *((char **)t2);
    t2 = xsi_get_transient_memory(10U);
    memset(t2, 0, 10U);
    t5 = t2;
    t6 = (t0 + 6498);
    memcpy(t5, t6, 2U);
    t5 = (t5 + 2U);
    t9 = (t0 + 6500);
    memcpy(t5, t9, 2U);
    t5 = (t5 + 2U);
    t11 = (t0 + 6502);
    memcpy(t5, t11, 2U);
    t5 = (t5 + 2U);
    t13 = (t0 + 6504);
    memcpy(t5, t13, 2U);
    t5 = (t5 + 2U);
    t15 = (t0 + 6506);
    memcpy(t5, t15, 2U);
    t21 = 1;
    if (10U == 10U)
        goto LAB18;

LAB19:    t21 = 0;

LAB20:    if (t21 == 0)
        goto LAB16;

LAB17:    xsi_set_current_line(116, ng0);
    t2 = (t0 + 1832U);
    t4 = *((char **)t2);
    t21 = *((unsigned char *)t4);
    t23 = (t21 == (unsigned char)2);
    if (t23 == 0)
        goto LAB24;

LAB25:    xsi_set_current_line(120, ng0);
    t2 = (t0 + 1992U);
    t4 = *((char **)t2);
    t21 = *((unsigned char *)t4);
    t23 = (t21 == (unsigned char)3);
    if (t23 == 0)
        goto LAB26;

LAB27:    xsi_set_current_line(126, ng0);
    t2 = xsi_get_transient_memory(10U);
    memset(t2, 0, 10U);
    t4 = t2;
    t5 = (t0 + 6591);
    memcpy(t4, t5, 2U);
    t4 = (t4 + 2U);
    t7 = (t0 + 6593);
    memcpy(t4, t7, 2U);
    t4 = (t4 + 2U);
    t10 = (t0 + 6595);
    memcpy(t4, t10, 2U);
    t4 = (t4 + 2U);
    t12 = (t0 + 6597);
    memcpy(t4, t12, 2U);
    t4 = (t4 + 2U);
    t14 = (t0 + 6599);
    memcpy(t4, t14, 2U);
    t16 = (t0 + 4032);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    memcpy(t20, t2, 10U);
    xsi_driver_first_trans_fast(t16);
    xsi_set_current_line(127, ng0);
    t2 = (t0 + 4096);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(128, ng0);
    t2 = (t0 + 2288U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 3328);
    xsi_process_wait(t2, t3);

LAB30:    *((char **)t1) = &&LAB31;
    goto LAB1;

LAB13:    goto LAB12;

LAB15:    goto LAB13;

LAB16:    t19 = (t0 + 6508);
    xsi_report(t19, 29U, (unsigned char)2);
    goto LAB17;

LAB18:    t22 = 0;

LAB21:    if (t22 < 10U)
        goto LAB22;
    else
        goto LAB20;

LAB22:    t17 = (t4 + t22);
    t18 = (t2 + t22);
    if (*((unsigned char *)t17) != *((unsigned char *)t18))
        goto LAB19;

LAB23:    t22 = (t22 + 1);
    goto LAB21;

LAB24:    t2 = (t0 + 6537);
    xsi_report(t2, 26U, (unsigned char)2);
    goto LAB25;

LAB26:    t2 = (t0 + 6563);
    xsi_report(t2, 28U, (unsigned char)2);
    goto LAB27;

LAB28:    xsi_set_current_line(130, ng0);
    t2 = (t0 + 1672U);
    t4 = *((char **)t2);
    t2 = xsi_get_transient_memory(10U);
    memset(t2, 0, 10U);
    t5 = t2;
    t6 = (t0 + 6601);
    memcpy(t5, t6, 2U);
    t5 = (t5 + 2U);
    t9 = (t0 + 6603);
    memcpy(t5, t9, 2U);
    t5 = (t5 + 2U);
    t11 = (t0 + 6605);
    memcpy(t5, t11, 2U);
    t5 = (t5 + 2U);
    t13 = (t0 + 6607);
    memcpy(t5, t13, 2U);
    t5 = (t5 + 2U);
    t15 = (t0 + 6609);
    memcpy(t5, t15, 2U);
    t21 = 1;
    if (10U == 10U)
        goto LAB34;

LAB35:    t21 = 0;

LAB36:    if (t21 == 0)
        goto LAB32;

LAB33:    xsi_set_current_line(134, ng0);
    t2 = (t0 + 1832U);
    t4 = *((char **)t2);
    t21 = *((unsigned char *)t4);
    t23 = (t21 == (unsigned char)2);
    if (t23 == 0)
        goto LAB40;

LAB41:    xsi_set_current_line(138, ng0);
    t2 = (t0 + 1992U);
    t4 = *((char **)t2);
    t21 = *((unsigned char *)t4);
    t23 = (t21 == (unsigned char)3);
    if (t23 == 0)
        goto LAB42;

LAB43:    xsi_set_current_line(143, ng0);
    t2 = xsi_get_transient_memory(10U);
    memset(t2, 0, 10U);
    t4 = t2;
    t5 = (t0 + 6694);
    memcpy(t4, t5, 2U);
    t4 = (t4 + 2U);
    t7 = (t0 + 6696);
    memcpy(t4, t7, 2U);
    t4 = (t4 + 2U);
    t10 = (t0 + 6698);
    memcpy(t4, t10, 2U);
    t4 = (t4 + 2U);
    t12 = (t0 + 6700);
    memcpy(t4, t12, 2U);
    t4 = (t4 + 2U);
    t14 = (t0 + 6702);
    memcpy(t4, t14, 2U);
    t16 = (t0 + 4032);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    memcpy(t20, t2, 10U);
    xsi_driver_first_trans_fast(t16);
    xsi_set_current_line(144, ng0);
    t2 = (t0 + 4096);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(145, ng0);
    t2 = (t0 + 2288U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 3328);
    xsi_process_wait(t2, t3);

LAB46:    *((char **)t1) = &&LAB47;
    goto LAB1;

LAB29:    goto LAB28;

LAB31:    goto LAB29;

LAB32:    t19 = (t0 + 6611);
    xsi_report(t19, 29U, (unsigned char)2);
    goto LAB33;

LAB34:    t22 = 0;

LAB37:    if (t22 < 10U)
        goto LAB38;
    else
        goto LAB36;

LAB38:    t17 = (t4 + t22);
    t18 = (t2 + t22);
    if (*((unsigned char *)t17) != *((unsigned char *)t18))
        goto LAB35;

LAB39:    t22 = (t22 + 1);
    goto LAB37;

LAB40:    t2 = (t0 + 6640);
    xsi_report(t2, 26U, (unsigned char)2);
    goto LAB41;

LAB42:    t2 = (t0 + 6666);
    xsi_report(t2, 28U, (unsigned char)2);
    goto LAB43;

LAB44:    xsi_set_current_line(147, ng0);
    t2 = (t0 + 1672U);
    t4 = *((char **)t2);
    t2 = xsi_get_transient_memory(10U);
    memset(t2, 0, 10U);
    t5 = t2;
    t6 = (t0 + 6704);
    memcpy(t5, t6, 2U);
    t5 = (t5 + 2U);
    t9 = (t0 + 6706);
    memcpy(t5, t9, 2U);
    t5 = (t5 + 2U);
    t11 = (t0 + 6708);
    memcpy(t5, t11, 2U);
    t5 = (t5 + 2U);
    t13 = (t0 + 6710);
    memcpy(t5, t13, 2U);
    t5 = (t5 + 2U);
    t15 = (t0 + 6712);
    memcpy(t5, t15, 2U);
    t21 = 1;
    if (10U == 10U)
        goto LAB50;

LAB51:    t21 = 0;

LAB52:    if (t21 == 0)
        goto LAB48;

LAB49:    xsi_set_current_line(151, ng0);
    t2 = (t0 + 1832U);
    t4 = *((char **)t2);
    t21 = *((unsigned char *)t4);
    t23 = (t21 == (unsigned char)2);
    if (t23 == 0)
        goto LAB56;

LAB57:    xsi_set_current_line(155, ng0);
    t2 = (t0 + 1992U);
    t4 = *((char **)t2);
    t21 = *((unsigned char *)t4);
    t23 = (t21 == (unsigned char)3);
    if (t23 == 0)
        goto LAB58;

LAB59:    xsi_set_current_line(161, ng0);
    t2 = xsi_get_transient_memory(10U);
    memset(t2, 0, 10U);
    t4 = t2;
    t5 = (t0 + 6797);
    memcpy(t4, t5, 2U);
    t4 = (t4 + 2U);
    t7 = (t0 + 6799);
    memcpy(t4, t7, 2U);
    t4 = (t4 + 2U);
    t10 = (t0 + 6801);
    memcpy(t4, t10, 2U);
    t4 = (t4 + 2U);
    t12 = (t0 + 6803);
    memcpy(t4, t12, 2U);
    t4 = (t4 + 2U);
    t14 = (t0 + 6805);
    memcpy(t4, t14, 2U);
    t16 = (t0 + 4032);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    memcpy(t20, t2, 10U);
    xsi_driver_first_trans_fast(t16);
    xsi_set_current_line(162, ng0);
    t2 = (t0 + 4096);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(163, ng0);
    t2 = (t0 + 2288U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 3328);
    xsi_process_wait(t2, t3);

LAB62:    *((char **)t1) = &&LAB63;
    goto LAB1;

LAB45:    goto LAB44;

LAB47:    goto LAB45;

LAB48:    t19 = (t0 + 6714);
    xsi_report(t19, 29U, (unsigned char)2);
    goto LAB49;

LAB50:    t22 = 0;

LAB53:    if (t22 < 10U)
        goto LAB54;
    else
        goto LAB52;

LAB54:    t17 = (t4 + t22);
    t18 = (t2 + t22);
    if (*((unsigned char *)t17) != *((unsigned char *)t18))
        goto LAB51;

LAB55:    t22 = (t22 + 1);
    goto LAB53;

LAB56:    t2 = (t0 + 6743);
    xsi_report(t2, 26U, (unsigned char)2);
    goto LAB57;

LAB58:    t2 = (t0 + 6769);
    xsi_report(t2, 28U, (unsigned char)2);
    goto LAB59;

LAB60:    xsi_set_current_line(165, ng0);
    t2 = (t0 + 1672U);
    t4 = *((char **)t2);
    t2 = xsi_get_transient_memory(10U);
    memset(t2, 0, 10U);
    t5 = t2;
    t6 = (t0 + 6807);
    memcpy(t5, t6, 2U);
    t5 = (t5 + 2U);
    t9 = (t0 + 6809);
    memcpy(t5, t9, 2U);
    t5 = (t5 + 2U);
    t11 = (t0 + 6811);
    memcpy(t5, t11, 2U);
    t5 = (t5 + 2U);
    t13 = (t0 + 6813);
    memcpy(t5, t13, 2U);
    t5 = (t5 + 2U);
    t15 = (t0 + 6815);
    memcpy(t5, t15, 2U);
    t21 = 1;
    if (10U == 10U)
        goto LAB66;

LAB67:    t21 = 0;

LAB68:    if (t21 == 0)
        goto LAB64;

LAB65:    xsi_set_current_line(169, ng0);
    t2 = (t0 + 1832U);
    t4 = *((char **)t2);
    t21 = *((unsigned char *)t4);
    t23 = (t21 == (unsigned char)2);
    if (t23 == 0)
        goto LAB72;

LAB73:    xsi_set_current_line(173, ng0);
    t2 = (t0 + 1992U);
    t4 = *((char **)t2);
    t21 = *((unsigned char *)t4);
    t23 = (t21 == (unsigned char)3);
    if (t23 == 0)
        goto LAB74;

LAB75:    xsi_set_current_line(179, ng0);
    t2 = xsi_get_transient_memory(10U);
    memset(t2, 0, 10U);
    t4 = t2;
    t5 = (t0 + 6900);
    memcpy(t4, t5, 2U);
    t4 = (t4 + 2U);
    t7 = (t0 + 6902);
    memcpy(t4, t7, 2U);
    t4 = (t4 + 2U);
    t10 = (t0 + 6904);
    memcpy(t4, t10, 2U);
    t4 = (t4 + 2U);
    t12 = (t0 + 6906);
    memcpy(t4, t12, 2U);
    t4 = (t4 + 2U);
    t14 = (t0 + 6908);
    memcpy(t4, t14, 2U);
    t16 = (t0 + 4032);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    memcpy(t20, t2, 10U);
    xsi_driver_first_trans_fast(t16);
    xsi_set_current_line(180, ng0);
    t2 = (t0 + 4096);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(181, ng0);
    t2 = (t0 + 2288U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 3328);
    xsi_process_wait(t2, t3);

LAB78:    *((char **)t1) = &&LAB79;
    goto LAB1;

LAB61:    goto LAB60;

LAB63:    goto LAB61;

LAB64:    t19 = (t0 + 6817);
    xsi_report(t19, 29U, (unsigned char)2);
    goto LAB65;

LAB66:    t22 = 0;

LAB69:    if (t22 < 10U)
        goto LAB70;
    else
        goto LAB68;

LAB70:    t17 = (t4 + t22);
    t18 = (t2 + t22);
    if (*((unsigned char *)t17) != *((unsigned char *)t18))
        goto LAB67;

LAB71:    t22 = (t22 + 1);
    goto LAB69;

LAB72:    t2 = (t0 + 6846);
    xsi_report(t2, 26U, (unsigned char)2);
    goto LAB73;

LAB74:    t2 = (t0 + 6872);
    xsi_report(t2, 28U, (unsigned char)2);
    goto LAB75;

LAB76:    xsi_set_current_line(183, ng0);
    t2 = (t0 + 1672U);
    t4 = *((char **)t2);
    t2 = xsi_get_transient_memory(10U);
    memset(t2, 0, 10U);
    t5 = t2;
    t6 = (t0 + 6910);
    memcpy(t5, t6, 2U);
    t5 = (t5 + 2U);
    t9 = (t0 + 6912);
    memcpy(t5, t9, 2U);
    t5 = (t5 + 2U);
    t11 = (t0 + 6914);
    memcpy(t5, t11, 2U);
    t5 = (t5 + 2U);
    t13 = (t0 + 6916);
    memcpy(t5, t13, 2U);
    t5 = (t5 + 2U);
    t15 = (t0 + 6918);
    memcpy(t5, t15, 2U);
    t21 = 1;
    if (10U == 10U)
        goto LAB82;

LAB83:    t21 = 0;

LAB84:    if (t21 == 0)
        goto LAB80;

LAB81:    xsi_set_current_line(187, ng0);
    t2 = (t0 + 1832U);
    t4 = *((char **)t2);
    t21 = *((unsigned char *)t4);
    t23 = (t21 == (unsigned char)2);
    if (t23 == 0)
        goto LAB88;

LAB89:    xsi_set_current_line(191, ng0);
    t2 = (t0 + 1992U);
    t4 = *((char **)t2);
    t21 = *((unsigned char *)t4);
    t23 = (t21 == (unsigned char)3);
    if (t23 == 0)
        goto LAB90;

LAB91:    xsi_set_current_line(198, ng0);
    t2 = xsi_get_transient_memory(10U);
    memset(t2, 0, 10U);
    t4 = t2;
    t5 = (t0 + 7003);
    memcpy(t4, t5, 2U);
    t4 = (t4 + 2U);
    t7 = (t0 + 7005);
    memcpy(t4, t7, 2U);
    t4 = (t4 + 2U);
    t10 = (t0 + 7007);
    memcpy(t4, t10, 2U);
    t4 = (t4 + 2U);
    t12 = (t0 + 7009);
    memcpy(t4, t12, 2U);
    t4 = (t4 + 2U);
    t14 = (t0 + 7011);
    memcpy(t4, t14, 2U);
    t16 = (t0 + 4032);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    memcpy(t20, t2, 10U);
    xsi_driver_first_trans_fast(t16);
    xsi_set_current_line(199, ng0);
    t2 = (t0 + 4096);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(200, ng0);
    t2 = (t0 + 2288U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 3328);
    xsi_process_wait(t2, t3);

LAB94:    *((char **)t1) = &&LAB95;
    goto LAB1;

LAB77:    goto LAB76;

LAB79:    goto LAB77;

LAB80:    t19 = (t0 + 6920);
    xsi_report(t19, 29U, (unsigned char)2);
    goto LAB81;

LAB82:    t22 = 0;

LAB85:    if (t22 < 10U)
        goto LAB86;
    else
        goto LAB84;

LAB86:    t17 = (t4 + t22);
    t18 = (t2 + t22);
    if (*((unsigned char *)t17) != *((unsigned char *)t18))
        goto LAB83;

LAB87:    t22 = (t22 + 1);
    goto LAB85;

LAB88:    t2 = (t0 + 6949);
    xsi_report(t2, 26U, (unsigned char)2);
    goto LAB89;

LAB90:    t2 = (t0 + 6975);
    xsi_report(t2, 28U, (unsigned char)2);
    goto LAB91;

LAB92:    xsi_set_current_line(202, ng0);
    t2 = (t0 + 1672U);
    t4 = *((char **)t2);
    t2 = xsi_get_transient_memory(10U);
    memset(t2, 0, 10U);
    t5 = t2;
    t6 = (t0 + 7013);
    memcpy(t5, t6, 2U);
    t5 = (t5 + 2U);
    t9 = (t0 + 7015);
    memcpy(t5, t9, 2U);
    t5 = (t5 + 2U);
    t11 = (t0 + 7017);
    memcpy(t5, t11, 2U);
    t5 = (t5 + 2U);
    t13 = (t0 + 7019);
    memcpy(t5, t13, 2U);
    t5 = (t5 + 2U);
    t15 = (t0 + 7021);
    memcpy(t5, t15, 2U);
    t21 = 1;
    if (10U == 10U)
        goto LAB98;

LAB99:    t21 = 0;

LAB100:    if (t21 == 0)
        goto LAB96;

LAB97:    xsi_set_current_line(206, ng0);
    t2 = (t0 + 1832U);
    t4 = *((char **)t2);
    t21 = *((unsigned char *)t4);
    t23 = (t21 == (unsigned char)2);
    if (t23 == 0)
        goto LAB104;

LAB105:    xsi_set_current_line(210, ng0);
    t2 = (t0 + 1992U);
    t4 = *((char **)t2);
    t21 = *((unsigned char *)t4);
    t23 = (t21 == (unsigned char)3);
    if (t23 == 0)
        goto LAB106;

LAB107:    xsi_set_current_line(214, ng0);
    t2 = xsi_get_transient_memory(10U);
    memset(t2, 0, 10U);
    t4 = t2;
    t5 = (t0 + 7106);
    memcpy(t4, t5, 2U);
    t4 = (t4 + 2U);
    t7 = (t0 + 7108);
    memcpy(t4, t7, 2U);
    t4 = (t4 + 2U);
    t10 = (t0 + 7110);
    memcpy(t4, t10, 2U);
    t4 = (t4 + 2U);
    t12 = (t0 + 7112);
    memcpy(t4, t12, 2U);
    t4 = (t4 + 2U);
    t14 = (t0 + 7114);
    memcpy(t4, t14, 2U);
    t16 = (t0 + 4032);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    memcpy(t20, t2, 10U);
    xsi_driver_first_trans_fast(t16);
    xsi_set_current_line(215, ng0);
    t2 = (t0 + 4096);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(216, ng0);
    t2 = (t0 + 2288U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 3328);
    xsi_process_wait(t2, t3);

LAB110:    *((char **)t1) = &&LAB111;
    goto LAB1;

LAB93:    goto LAB92;

LAB95:    goto LAB93;

LAB96:    t19 = (t0 + 7023);
    xsi_report(t19, 29U, (unsigned char)2);
    goto LAB97;

LAB98:    t22 = 0;

LAB101:    if (t22 < 10U)
        goto LAB102;
    else
        goto LAB100;

LAB102:    t17 = (t4 + t22);
    t18 = (t2 + t22);
    if (*((unsigned char *)t17) != *((unsigned char *)t18))
        goto LAB99;

LAB103:    t22 = (t22 + 1);
    goto LAB101;

LAB104:    t2 = (t0 + 7052);
    xsi_report(t2, 26U, (unsigned char)2);
    goto LAB105;

LAB106:    t2 = (t0 + 7078);
    xsi_report(t2, 28U, (unsigned char)2);
    goto LAB107;

LAB108:    xsi_set_current_line(218, ng0);
    t2 = (t0 + 1672U);
    t4 = *((char **)t2);
    t2 = xsi_get_transient_memory(10U);
    memset(t2, 0, 10U);
    t5 = t2;
    t6 = (t0 + 7116);
    memcpy(t5, t6, 2U);
    t5 = (t5 + 2U);
    t9 = (t0 + 7118);
    memcpy(t5, t9, 2U);
    t5 = (t5 + 2U);
    t11 = (t0 + 7120);
    memcpy(t5, t11, 2U);
    t5 = (t5 + 2U);
    t13 = (t0 + 7122);
    memcpy(t5, t13, 2U);
    t5 = (t5 + 2U);
    t15 = (t0 + 7124);
    memcpy(t5, t15, 2U);
    t21 = 1;
    if (10U == 10U)
        goto LAB114;

LAB115:    t21 = 0;

LAB116:    if (t21 == 0)
        goto LAB112;

LAB113:    xsi_set_current_line(222, ng0);
    t2 = (t0 + 1832U);
    t4 = *((char **)t2);
    t21 = *((unsigned char *)t4);
    t23 = (t21 == (unsigned char)2);
    if (t23 == 0)
        goto LAB120;

LAB121:    xsi_set_current_line(226, ng0);
    t2 = (t0 + 1992U);
    t4 = *((char **)t2);
    t21 = *((unsigned char *)t4);
    t23 = (t21 == (unsigned char)3);
    if (t23 == 0)
        goto LAB122;

LAB123:    xsi_set_current_line(232, ng0);
    t2 = xsi_get_transient_memory(10U);
    memset(t2, 0, 10U);
    t4 = t2;
    t5 = (t0 + 7209);
    memcpy(t4, t5, 2U);
    t4 = (t4 + 2U);
    t7 = (t0 + 7211);
    memcpy(t4, t7, 2U);
    t4 = (t4 + 2U);
    t10 = (t0 + 7213);
    memcpy(t4, t10, 2U);
    t4 = (t4 + 2U);
    t12 = (t0 + 7215);
    memcpy(t4, t12, 2U);
    t4 = (t4 + 2U);
    t14 = (t0 + 7217);
    memcpy(t4, t14, 2U);
    t16 = (t0 + 4032);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    memcpy(t20, t2, 10U);
    xsi_driver_first_trans_fast(t16);
    xsi_set_current_line(233, ng0);
    t2 = (t0 + 4096);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(234, ng0);
    t2 = (t0 + 2288U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 3328);
    xsi_process_wait(t2, t3);

LAB126:    *((char **)t1) = &&LAB127;
    goto LAB1;

LAB109:    goto LAB108;

LAB111:    goto LAB109;

LAB112:    t19 = (t0 + 7126);
    xsi_report(t19, 29U, (unsigned char)2);
    goto LAB113;

LAB114:    t22 = 0;

LAB117:    if (t22 < 10U)
        goto LAB118;
    else
        goto LAB116;

LAB118:    t17 = (t4 + t22);
    t18 = (t2 + t22);
    if (*((unsigned char *)t17) != *((unsigned char *)t18))
        goto LAB115;

LAB119:    t22 = (t22 + 1);
    goto LAB117;

LAB120:    t2 = (t0 + 7155);
    xsi_report(t2, 26U, (unsigned char)2);
    goto LAB121;

LAB122:    t2 = (t0 + 7181);
    xsi_report(t2, 28U, (unsigned char)2);
    goto LAB123;

LAB124:    xsi_set_current_line(236, ng0);
    t2 = (t0 + 1672U);
    t4 = *((char **)t2);
    t2 = xsi_get_transient_memory(10U);
    memset(t2, 0, 10U);
    t5 = t2;
    t6 = (t0 + 7219);
    memcpy(t5, t6, 2U);
    t5 = (t5 + 2U);
    t9 = (t0 + 7221);
    memcpy(t5, t9, 2U);
    t5 = (t5 + 2U);
    t11 = (t0 + 7223);
    memcpy(t5, t11, 2U);
    t5 = (t5 + 2U);
    t13 = (t0 + 7225);
    memcpy(t5, t13, 2U);
    t5 = (t5 + 2U);
    t15 = (t0 + 7227);
    memcpy(t5, t15, 2U);
    t21 = 1;
    if (10U == 10U)
        goto LAB130;

LAB131:    t21 = 0;

LAB132:    if (t21 == 0)
        goto LAB128;

LAB129:    xsi_set_current_line(240, ng0);
    t2 = (t0 + 1832U);
    t4 = *((char **)t2);
    t21 = *((unsigned char *)t4);
    t23 = (t21 == (unsigned char)2);
    if (t23 == 0)
        goto LAB136;

LAB137:    xsi_set_current_line(244, ng0);
    t2 = (t0 + 1992U);
    t4 = *((char **)t2);
    t21 = *((unsigned char *)t4);
    t23 = (t21 == (unsigned char)3);
    if (t23 == 0)
        goto LAB138;

LAB139:    xsi_set_current_line(249, ng0);
    t2 = xsi_get_transient_memory(10U);
    memset(t2, 0, 10U);
    t4 = t2;
    t5 = (t0 + 7312);
    memcpy(t4, t5, 2U);
    t4 = (t4 + 2U);
    t7 = (t0 + 7314);
    memcpy(t4, t7, 2U);
    t4 = (t4 + 2U);
    t10 = (t0 + 7316);
    memcpy(t4, t10, 2U);
    t4 = (t4 + 2U);
    t12 = (t0 + 7318);
    memcpy(t4, t12, 2U);
    t4 = (t4 + 2U);
    t14 = (t0 + 7320);
    memcpy(t4, t14, 2U);
    t16 = (t0 + 4032);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    memcpy(t20, t2, 10U);
    xsi_driver_first_trans_fast(t16);
    xsi_set_current_line(250, ng0);
    t2 = (t0 + 4096);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(251, ng0);
    t2 = (t0 + 2288U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 3328);
    xsi_process_wait(t2, t3);

LAB142:    *((char **)t1) = &&LAB143;
    goto LAB1;

LAB125:    goto LAB124;

LAB127:    goto LAB125;

LAB128:    t19 = (t0 + 7229);
    xsi_report(t19, 29U, (unsigned char)2);
    goto LAB129;

LAB130:    t22 = 0;

LAB133:    if (t22 < 10U)
        goto LAB134;
    else
        goto LAB132;

LAB134:    t17 = (t4 + t22);
    t18 = (t2 + t22);
    if (*((unsigned char *)t17) != *((unsigned char *)t18))
        goto LAB131;

LAB135:    t22 = (t22 + 1);
    goto LAB133;

LAB136:    t2 = (t0 + 7258);
    xsi_report(t2, 26U, (unsigned char)2);
    goto LAB137;

LAB138:    t2 = (t0 + 7284);
    xsi_report(t2, 28U, (unsigned char)2);
    goto LAB139;

LAB140:    xsi_set_current_line(253, ng0);
    t2 = (t0 + 1672U);
    t4 = *((char **)t2);
    t2 = xsi_get_transient_memory(10U);
    memset(t2, 0, 10U);
    t5 = t2;
    t6 = (t0 + 7322);
    memcpy(t5, t6, 2U);
    t5 = (t5 + 2U);
    t9 = (t0 + 7324);
    memcpy(t5, t9, 2U);
    t5 = (t5 + 2U);
    t11 = (t0 + 7326);
    memcpy(t5, t11, 2U);
    t5 = (t5 + 2U);
    t13 = (t0 + 7328);
    memcpy(t5, t13, 2U);
    t5 = (t5 + 2U);
    t15 = (t0 + 7330);
    memcpy(t5, t15, 2U);
    t21 = 1;
    if (10U == 10U)
        goto LAB146;

LAB147:    t21 = 0;

LAB148:    if (t21 == 0)
        goto LAB144;

LAB145:    xsi_set_current_line(257, ng0);
    t2 = (t0 + 1832U);
    t4 = *((char **)t2);
    t21 = *((unsigned char *)t4);
    t23 = (t21 == (unsigned char)3);
    if (t23 == 0)
        goto LAB152;

LAB153:    xsi_set_current_line(261, ng0);
    t2 = (t0 + 1992U);
    t4 = *((char **)t2);
    t21 = *((unsigned char *)t4);
    t23 = (t21 == (unsigned char)2);
    if (t23 == 0)
        goto LAB154;

LAB155:    xsi_set_current_line(265, ng0);

LAB158:    *((char **)t1) = &&LAB159;
    goto LAB1;

LAB141:    goto LAB140;

LAB143:    goto LAB141;

LAB144:    t19 = (t0 + 7332);
    xsi_report(t19, 29U, (unsigned char)2);
    goto LAB145;

LAB146:    t22 = 0;

LAB149:    if (t22 < 10U)
        goto LAB150;
    else
        goto LAB148;

LAB150:    t17 = (t4 + t22);
    t18 = (t2 + t22);
    if (*((unsigned char *)t17) != *((unsigned char *)t18))
        goto LAB147;

LAB151:    t22 = (t22 + 1);
    goto LAB149;

LAB152:    t2 = (t0 + 7361);
    xsi_report(t2, 26U, (unsigned char)2);
    goto LAB153;

LAB154:    t2 = (t0 + 7387);
    xsi_report(t2, 28U, (unsigned char)2);
    goto LAB155;

LAB156:    goto LAB2;

LAB157:    goto LAB156;

LAB159:    goto LAB157;

}


extern void work_a_0462189711_2372691052_init()
{
	static char *pe[] = {(void *)work_a_0462189711_2372691052_p_0,(void *)work_a_0462189711_2372691052_p_1};
	xsi_register_didat("work_a_0462189711_2372691052", "isim/TB_modulo_isim_beh.exe.sim/work/a_0462189711_2372691052.didat");
	xsi_register_executes(pe);
}

<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="artix7" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="XLXN_2" />
        <signal name="XLXN_7" />
        <signal name="XLXN_9" />
        <signal name="XLXN_10" />
        <signal name="XLXN_12" />
        <signal name="XLXN_13" />
        <signal name="XLXN_17" />
        <signal name="XLXN_18" />
        <signal name="XLXN_19" />
        <signal name="XLXN_20" />
        <signal name="XLXN_21" />
        <signal name="XLXN_22" />
        <signal name="XLXN_23" />
        <signal name="XLXN_28" />
        <signal name="XLXN_30" />
        <signal name="XLXN_1" />
        <signal name="XLXN_6" />
        <signal name="XLXN_3" />
        <signal name="A" />
        <signal name="XLXN_37" />
        <signal name="B" />
        <signal name="XLXN_39" />
        <signal name="C" />
        <signal name="Z" />
        <port polarity="Input" name="A" />
        <port polarity="Input" name="B" />
        <port polarity="Input" name="C" />
        <port polarity="Output" name="Z" />
        <blockdef name="copy_of_or3">
            <timestamp>2015-1-15T17:25:37</timestamp>
            <line x2="48" y1="-64" y2="-64" x1="0" />
            <line x2="72" y1="-128" y2="-128" x1="0" />
            <line x2="48" y1="-192" y2="-192" x1="0" />
            <line x2="192" y1="-128" y2="-128" x1="256" />
            <arc ex="192" ey="-128" sx="112" sy="-80" r="88" cx="116" cy="-168" />
            <arc ex="48" ey="-176" sx="48" sy="-80" r="56" cx="16" cy="-128" />
            <line x2="48" y1="-64" y2="-80" x1="48" />
            <line x2="48" y1="-192" y2="-176" x1="48" />
            <line x2="48" y1="-80" y2="-80" x1="112" />
            <arc ex="112" ey="-176" sx="192" sy="-128" r="88" cx="116" cy="-88" />
            <line x2="48" y1="-176" y2="-176" x1="112" />
        </blockdef>
        <blockdef name="copy_of_and2">
            <timestamp>2015-1-15T17:25:9</timestamp>
            <line x2="64" y1="-64" y2="-64" x1="0" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="192" y1="-96" y2="-96" x1="256" />
            <arc ex="144" ey="-144" sx="144" sy="-48" r="48" cx="144" cy="-96" />
            <line x2="64" y1="-48" y2="-48" x1="144" />
            <line x2="144" y1="-144" y2="-144" x1="64" />
            <line x2="64" y1="-48" y2="-144" x1="64" />
        </blockdef>
        <block symbolname="copy_of_and2" name="XLXI_4">
            <blockpin signalname="C" name="I0" />
            <blockpin signalname="B" name="I1" />
            <blockpin signalname="XLXN_3" name="O" />
        </block>
        <block symbolname="copy_of_and2" name="XLXI_3">
            <blockpin signalname="B" name="I0" />
            <blockpin signalname="A" name="I1" />
            <blockpin signalname="XLXN_1" name="O" />
        </block>
        <block symbolname="copy_of_and2" name="XLXI_5">
            <blockpin signalname="C" name="I0" />
            <blockpin signalname="A" name="I1" />
            <blockpin signalname="XLXN_6" name="O" />
        </block>
        <block symbolname="copy_of_or3" name="XLXI_2">
            <blockpin signalname="XLXN_6" name="I0" />
            <blockpin signalname="XLXN_3" name="I1" />
            <blockpin signalname="XLXN_1" name="I2" />
            <blockpin signalname="Z" name="O" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="1760" height="1360">
        <branch name="XLXN_1">
            <wire x2="976" y1="496" y2="496" x1="928" />
            <wire x2="976" y1="496" y2="608" x1="976" />
        </branch>
        <branch name="XLXN_6">
            <wire x2="976" y1="848" y2="848" x1="928" />
            <wire x2="976" y1="736" y2="848" x1="976" />
        </branch>
        <branch name="XLXN_3">
            <wire x2="976" y1="672" y2="672" x1="928" />
        </branch>
        <branch name="A">
            <wire x2="576" y1="464" y2="464" x1="464" />
            <wire x2="672" y1="464" y2="464" x1="576" />
            <wire x2="576" y1="464" y2="816" x1="576" />
            <wire x2="672" y1="816" y2="816" x1="576" />
        </branch>
        <branch name="B">
            <wire x2="640" y1="640" y2="640" x1="464" />
            <wire x2="672" y1="640" y2="640" x1="640" />
            <wire x2="672" y1="528" y2="528" x1="640" />
            <wire x2="640" y1="528" y2="640" x1="640" />
        </branch>
        <branch name="C">
            <wire x2="640" y1="880" y2="880" x1="464" />
            <wire x2="672" y1="880" y2="880" x1="640" />
            <wire x2="672" y1="704" y2="704" x1="640" />
            <wire x2="640" y1="704" y2="880" x1="640" />
        </branch>
        <branch name="Z">
            <wire x2="1328" y1="672" y2="672" x1="1232" />
        </branch>
        <rect width="736" x="512" y="368" height="596" />
        <instance x="672" y="768" name="XLXI_4" orien="R0" />
        <instance x="672" y="592" name="XLXI_3" orien="R0" />
        <instance x="672" y="944" name="XLXI_5" orien="R0" />
        <instance x="976" y="800" name="XLXI_2" orien="R0" />
        <iomarker fontsize="28" x="464" y="464" name="A" orien="R180" />
        <iomarker fontsize="28" x="464" y="640" name="B" orien="R180" />
        <iomarker fontsize="28" x="464" y="880" name="C" orien="R180" />
        <iomarker fontsize="28" x="1328" y="672" name="Z" orien="R0" />
        <text style="fontsize:60;fontname:Arial" x="936" y="420">mi_votador</text>
    </sheet>
</drawing>
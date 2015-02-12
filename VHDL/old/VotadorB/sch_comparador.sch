<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="artix7" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="XLXN_1" />
        <signal name="A" />
        <signal name="B" />
        <signal name="Z" />
        <signal name="clk" />
        <port polarity="Input" name="A" />
        <port polarity="Input" name="B" />
        <port polarity="Output" name="Z" />
        <port polarity="Input" name="clk" />
        <blockdef name="copy_of_xnor2">
            <timestamp>2015-1-15T17:10:8</timestamp>
            <line x2="64" y1="-64" y2="-64" x1="0" />
            <line x2="60" y1="-128" y2="-128" x1="0" />
            <arc ex="44" ey="-144" sx="48" sy="-48" r="56" cx="16" cy="-96" />
            <arc ex="64" ey="-144" sx="64" sy="-48" r="56" cx="32" cy="-96" />
            <line x2="64" y1="-144" y2="-144" x1="128" />
            <line x2="64" y1="-48" y2="-48" x1="128" />
            <arc ex="128" ey="-144" sx="208" sy="-96" r="88" cx="132" cy="-56" />
            <arc ex="208" ey="-96" sx="128" sy="-48" r="88" cx="132" cy="-136" />
            <circle r="8" cx="220" cy="-96" />
            <line x2="256" y1="-96" y2="-96" x1="228" />
            <line x2="60" y1="-28" y2="-28" x1="60" />
        </blockdef>
        <blockdef name="copy_of_fd">
            <timestamp>2015-1-15T17:11:52</timestamp>
            <rect width="256" x="64" y="-320" height="256" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="64" y1="-256" y2="-256" x1="0" />
            <line x2="320" y1="-256" y2="-256" x1="384" />
            <line x2="64" y1="-128" y2="-144" x1="80" />
            <line x2="80" y1="-112" y2="-128" x1="64" />
        </blockdef>
        <block symbolname="copy_of_xnor2" name="XLXI_9">
            <blockpin signalname="B" name="I0" />
            <blockpin signalname="A" name="I1" />
            <blockpin signalname="XLXN_1" name="O" />
        </block>
        <block symbolname="copy_of_fd" name="XLXI_10">
            <blockpin signalname="clk" name="C" />
            <blockpin signalname="XLXN_1" name="D" />
            <blockpin signalname="Z" name="Q" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="1760" height="1360">
        <branch name="XLXN_1">
            <wire x2="928" y1="640" y2="640" x1="768" />
            <wire x2="928" y1="640" y2="656" x1="928" />
            <wire x2="944" y1="656" y2="656" x1="928" />
        </branch>
        <rect width="956" x="404" y="420" height="492" />
        <branch name="A">
            <wire x2="496" y1="592" y2="592" x1="336" />
            <wire x2="496" y1="592" y2="608" x1="496" />
            <wire x2="512" y1="608" y2="608" x1="496" />
        </branch>
        <branch name="B">
            <wire x2="496" y1="688" y2="688" x1="336" />
            <wire x2="512" y1="672" y2="672" x1="496" />
            <wire x2="496" y1="672" y2="688" x1="496" />
        </branch>
        <branch name="Z">
            <wire x2="1456" y1="656" y2="656" x1="1328" />
        </branch>
        <text style="fontsize:60;fontname:Arial;textcolor:rgb(0,0,0)" x="440" y="476">mi_comp</text>
        <branch name="clk">
            <wire x2="928" y1="784" y2="784" x1="368" />
            <wire x2="944" y1="784" y2="784" x1="928" />
        </branch>
        <instance x="512" y="736" name="XLXI_9" orien="R0" />
        <instance x="944" y="912" name="XLXI_10" orien="R0" />
        <iomarker fontsize="52" x="1456" y="656" name="Z" orien="R0" />
        <iomarker fontsize="52" x="368" y="784" name="clk" orien="R180" />
        <iomarker fontsize="52" x="336" y="688" name="B" orien="R180" />
        <iomarker fontsize="52" x="336" y="592" name="A" orien="R180" />
    </sheet>
</drawing>
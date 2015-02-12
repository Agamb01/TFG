<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="artix7" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="XLXN_13" />
        <signal name="XLXN_15" />
        <signal name="XLXN_16" />
        <signal name="XLXN_18" />
        <signal name="XLXN_19" />
        <signal name="XLXN_25" />
        <signal name="XLXN_29" />
        <signal name="XLXN_2" />
        <signal name="XLXN_3" />
        <signal name="XLXN_34" />
        <signal name="XLXN_1" />
        <signal name="A" />
        <signal name="B" />
        <signal name="XLXN_38" />
        <signal name="clk" />
        <signal name="Z" />
        <port polarity="Input" name="A" />
        <port polarity="Input" name="B" />
        <port polarity="Input" name="clk" />
        <port polarity="Output" name="Z" />
        <blockdef name="mi_comp">
            <timestamp>2015-1-15T18:4:57</timestamp>
            <rect width="128" x="64" y="-192" height="128" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="256" y1="-160" y2="-160" x1="192" />
            <line x2="116" y1="-64" y2="-48" x1="116" />
            <line x2="0" y1="-48" y2="-48" x1="116" />
        </blockdef>
        <blockdef name="mi_votador">
            <timestamp>2015-1-15T18:12:36</timestamp>
            <rect width="224" x="64" y="-192" height="192" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="352" y1="-160" y2="-160" x1="288" />
        </blockdef>
        <block symbolname="mi_comp" name="XLXI_1">
            <blockpin signalname="A" name="A" />
            <blockpin signalname="B" name="B" />
            <blockpin signalname="XLXN_3" name="Z" />
            <blockpin signalname="clk" name="clk" />
        </block>
        <block symbolname="mi_comp" name="XLXI_3">
            <blockpin signalname="A" name="A" />
            <blockpin signalname="B" name="B" />
            <blockpin signalname="XLXN_2" name="Z" />
            <blockpin signalname="clk" name="clk" />
        </block>
        <block symbolname="mi_comp" name="XLXI_4">
            <blockpin signalname="A" name="A" />
            <blockpin signalname="B" name="B" />
            <blockpin signalname="XLXN_1" name="Z" />
            <blockpin signalname="clk" name="clk" />
        </block>
        <block symbolname="mi_votador" name="XLXI_5">
            <blockpin signalname="XLXN_3" name="A" />
            <blockpin signalname="XLXN_2" name="B" />
            <blockpin signalname="XLXN_1" name="C" />
            <blockpin signalname="Z" name="Z" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="1760" height="1360">
        <instance x="560" y="496" name="XLXI_1" orien="R0">
        </instance>
        <instance x="560" y="752" name="XLXI_3" orien="R0">
        </instance>
        <instance x="560" y="1008" name="XLXI_4" orien="R0">
        </instance>
        <branch name="XLXN_2">
            <wire x2="944" y1="592" y2="592" x1="816" />
        </branch>
        <instance x="944" y="688" name="XLXI_5" orien="R0">
        </instance>
        <branch name="XLXN_3">
            <wire x2="832" y1="336" y2="336" x1="816" />
            <wire x2="832" y1="336" y2="528" x1="832" />
            <wire x2="944" y1="528" y2="528" x1="832" />
        </branch>
        <branch name="XLXN_1">
            <wire x2="832" y1="848" y2="848" x1="816" />
            <wire x2="944" y1="656" y2="656" x1="832" />
            <wire x2="832" y1="656" y2="848" x1="832" />
        </branch>
        <branch name="A">
            <wire x2="448" y1="336" y2="336" x1="368" />
            <wire x2="560" y1="336" y2="336" x1="448" />
            <wire x2="448" y1="336" y2="592" x1="448" />
            <wire x2="560" y1="592" y2="592" x1="448" />
            <wire x2="448" y1="592" y2="848" x1="448" />
            <wire x2="560" y1="848" y2="848" x1="448" />
        </branch>
        <branch name="B">
            <wire x2="496" y1="400" y2="400" x1="368" />
            <wire x2="496" y1="400" y2="656" x1="496" />
            <wire x2="496" y1="656" y2="912" x1="496" />
            <wire x2="560" y1="912" y2="912" x1="496" />
            <wire x2="560" y1="656" y2="656" x1="496" />
            <wire x2="560" y1="400" y2="400" x1="496" />
        </branch>
        <branch name="clk">
            <wire x2="544" y1="960" y2="960" x1="368" />
            <wire x2="560" y1="960" y2="960" x1="544" />
            <wire x2="560" y1="448" y2="448" x1="544" />
            <wire x2="544" y1="448" y2="704" x1="544" />
            <wire x2="560" y1="704" y2="704" x1="544" />
            <wire x2="544" y1="704" y2="960" x1="544" />
        </branch>
        <branch name="Z">
            <wire x2="1328" y1="528" y2="528" x1="1296" />
        </branch>
        <iomarker fontsize="28" x="368" y="336" name="A" orien="R180" />
        <iomarker fontsize="28" x="368" y="400" name="B" orien="R180" />
        <iomarker fontsize="28" x="368" y="960" name="clk" orien="R180" />
        <iomarker fontsize="28" x="1328" y="528" name="Z" orien="R0" />
    </sheet>
</drawing>
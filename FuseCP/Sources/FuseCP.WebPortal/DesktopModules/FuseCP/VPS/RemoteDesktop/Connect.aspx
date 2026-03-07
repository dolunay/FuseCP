<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Connect.aspx.cs" Inherits="FuseCP.Portal.VPS.RemoteDesktop.Connect" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>
        <asp:Literal ID="litServerName" runat="server"></asp:Literal>
        <asp:Localize ID="locTitle" runat="server" meta:resourcekey="locTitle" Text="Remote Desktop Web Connection"></asp:Localize></title>
</head>
<body style="margin:0">


<input type="hidden" id="rdpConnectConfig"
    data-resolution="<asp:Literal id='resolution' runat='server'/>"
    data-server-name="<asp:Literal id='serverName' runat='server'/>"
    data-username="<asp:Literal id='username' runat='server'/>"
    data-password="<asp:Literal id='password' runat='server'/>" />
<script language="vbscript" type="text/vbscript" src="/DesktopModules/FuseCP/Scripts/rdp-connect.vbs"></script>

<object language="vbscript" id="MsRdpClient"
    onreadystatechange="OnControlLoad"
    classid="CLSID:9059f30f-4eb1-4bd2-9fdc-36f43a218f4a"
    codebase="msrdp.cab#version=5,1,2600,2180"
    height="100">
</object>

    <form id="AspForm" runat="server">
    </form>
</body>
</html>

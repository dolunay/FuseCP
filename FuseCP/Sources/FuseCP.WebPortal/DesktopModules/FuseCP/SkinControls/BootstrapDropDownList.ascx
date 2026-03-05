<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BootstrapDropDownList.ascx.cs" Inherits="FuseCP.Portal.SkinControls.BootstrapDropDownList" %>

<div id="ddl" runat="server">
    <input type="hidden" id="hdSelectedIndex" runat="server" />
    <button ID="btn" runat="server" type="button" class="dropdown-toggle" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        <span id="lit" runat="server">...</span>
    </button>
    <input type="hidden" id="hdSelectedValue" runat="server" />
</div>

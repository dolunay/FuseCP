<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Menu.ascx.cs" Inherits="FuseCP.Portal.VPS.UserControls.Menu" %>
<ul class="nav nav-tabs">

	<asp:DataList runat="server" ID="MenuItems" EnableViewState="false" RepeatDirection="Horizontal" RepeatLayout="Flow">
	    <ItemTemplate>
	        <li role="presentation">
                <asp:HyperLink ID="lnkItem" runat="server" NavigateUrl='<%# Eval("Url") %>' Text='<%# Eval("Text") %>'/>			                
            </li>
	    </ItemTemplate>
	    <SelectedItemTemplate>
            <li role="presentation" class="active">
                <asp:HyperLink ID="lnkItem" runat="server"
	                NavigateUrl='<%# Eval("Url") %>'
	                Text='<%# Eval("Text") %>'/>			                
            </li>
        </SelectedItemTemplate>
	</asp:DataList>	
</ul>
<script type="text/javascript" src="/DesktopModules/FuseCP/Scripts/websites-edit-site.js"></script>

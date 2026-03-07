<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="VpsDetailsAuditLog.ascx.cs" Inherits="FuseCP.Portal.VPS.VpsDetailsAuditLog" %>
<%@ Register Src="../UserControls/SimpleMessageBox.ascx" TagName="SimpleMessageBox" TagPrefix="fcp" %>
<%@ Register Src="UserControls/ServerTabs.ascx" TagName="ServerTabs" TagPrefix="fcp" %>
<%@ Register Src="UserControls/Menu.ascx" TagName="Menu" TagPrefix="fcp" %>
<%@ Register Src="UserControls/Breadcrumb.ascx" TagName="Breadcrumb" TagPrefix="fcp" %>
<%@ Register Src="UserControls/FormTitle.ascx" TagName="FormTitle" TagPrefix="fcp" %>
<%@ Register Src="../UserControls/AuditLogControl.ascx" TagName="AuditLogControl" TagPrefix="fcp" %>

	    <div class="card">
			    <div class="card-header">
				    <asp:Image ID="imgIcon" SkinID="AuditLog48" runat="server" />
				    <fcp:FormTitle ID="locTitle" runat="server" meta:resourcekey="locTitle" Text="Audit Log" />
			    </div>
			    <div class="card-body form-horizontal">
                     <fcp:Menu id="menu" runat="server" SelectedItem="" />
                <div class="card tab-content">
                <div class="card-body form-horizontal">
                    <fcp:SimpleMessageBox id="messageBox" runat="server" />
			        <fcp:ServerTabs id="tabs" runat="server" SelectedTab="vps_audit_log" />	
                    
				    <fcp:AuditLogControl id="auditLog" runat="server" LogSource="VPS" />
				    
		</div>
        </div>
                </div>
                </div>

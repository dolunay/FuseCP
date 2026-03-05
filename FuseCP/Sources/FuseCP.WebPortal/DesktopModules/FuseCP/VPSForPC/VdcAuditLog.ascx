<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="VdcAuditLog.ascx.cs" Inherits="FuseCP.Portal.VPSForPC.VdcAuditLog" %>
<%@ Register Src="../UserControls/SimpleMessageBox.ascx" TagName="SimpleMessageBox" TagPrefix="fcp" %>
<%@ Register Src="../UserControls/PopupHeader.ascx" TagName="PopupHeader" TagPrefix="fcp" %>
<%@ Register Src="../UserControls/AuditLogControl.ascx" TagName="AuditLogControl" TagPrefix="fcp" %>
<%@ Register Src="UserControls/Menu.ascx" TagName="Menu" TagPrefix="fcp" %>
<%@ Register Src="UserControls/Breadcrumb.ascx" TagName="Breadcrumb" TagPrefix="fcp" %>

	
	    <div class="card">
			    <div class="card-header">
				    <asp:Image ID="imgIcon" SkinID="AuditLog48" runat="server" />
				    <asp:Localize ID="locTitle" runat="server" meta:resourcekey="locTitle" Text="Audit Log"></asp:Localize>
			    </div>
            <div class="card-body form-horizontal">
            <fcp:Menu id="menu" runat="server" SelectedItem="vdc_audit_log" />
			    <div class="card tab-content">
                <div class="card-body form-horizontal">
                    <fcp:AuditLogControl id="auditLog" runat="server" LogSource="VPSForPC" />
			    </div>
		    </div>
            </div>
            </div>
		    <div class="alert alert-info">
			    <asp:Localize ID="FormComments" runat="server" meta:resourcekey="FormComments"></asp:Localize>
		    </div>

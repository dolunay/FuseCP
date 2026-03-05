<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="VdcAddExternalAddress.ascx.cs" Inherits="FuseCP.Portal.VPSForPC.VdcAddExternalAddress" %>
<%@ Register Src="UserControls/Menu.ascx" TagName="Menu" TagPrefix="fcp" %>
<%@ Register Src="UserControls/Breadcrumb.ascx" TagName="Breadcrumb" TagPrefix="fcp" %>
<%@ Register Src="../UserControls/AllocatePackageIPAddresses.ascx" TagName="AllocatePackageIPAddresses" TagPrefix="fcp" %>
<%@ Register Src="../UserControls/EnableAsyncTasksSupport.ascx" TagName="EnableAsyncTasksSupport" TagPrefix="fcp" %>

<fcp:EnableAsyncTasksSupport id="asyncTasks" runat="server"/> 	
	    <div class="card">
                <div class="card-header">
				    <asp:Image ID="imgIcon" SkinID="Network48" runat="server" />
				    <asp:Localize ID="locTitle" runat="server" meta:resourcekey="locTitle" Text="Allocate IP Addresses"></asp:Localize>
			    </div>
            <div class="card-body form-horizontal">
                <fcp:Menu id="menu" runat="server" SelectedItem="vdc_external_network" />
                <div class="card tab-content">
                <div class="card-body form-horizontal">
                <fcp:AllocatePackageIPAddresses id="allocateAddresses" runat="server"
                        Pool="VpsExternalNetwork"
                        ResourceGroup="VPS"
                        ListAddressesControl="vdc_external_network" />
				    
			    </div>
		    </div>
                </div>
            </div>
		    <div class="Right">
			    <asp:Localize ID="FormComments" runat="server" meta:resourcekey="FormComments"></asp:Localize>
		    </div>

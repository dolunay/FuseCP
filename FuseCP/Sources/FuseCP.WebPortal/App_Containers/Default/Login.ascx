<%@ Control language="C#" AutoEventWireup="false" %>
<div class="card">
  <div class="card-header">
    <h2 class="card-title">
    <asp:Image ID="imgModuleIcon" runat="server" alt="" />
    <asp:Label ID="lblModuleTitle" runat="server"></asp:Label>
    </h2>
  </div>
  <asp:PlaceHolder ID="ContentPane" runat="server"/>
</div>

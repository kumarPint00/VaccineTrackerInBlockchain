
App={
    contract:{},
    init: async function(){
    console.log("init is called");
    const provider = new ethers.providers.Web3Provider(window.ethereum,"any");

    await provider.send("eth_requestAccounts",[]);

    const signer = provider.getSigner();

    let userAddress = await signer.getAddress();
    
    document.getElementById("wallet").innerText= "Your wallet address is:"+ userAddress;
    const resourceAddress = "0xd7938fA8580068A5Daa09A390dE3D0df77a56bA9";

    console.log(userAddress);
    $.getJSON(
        "../artifacts/contracts/VaccineTracker.sol/VaccineTracker.json", function(VaccineTrackerArtifacts){
            console.log(VaccineTrackerArtifacts);

            const contract = new ethers.Contract(
                resourceAddress,
                VaccineTrackerArtifacts.abi, 
                signer
            );
            App.contract= contract;
            
            console.log(resourceAddress);
            contract.viewVaccine(1).then((data)=>{
                console.log(data);


            });
        });
        return App.bindEvents();

    },
    bindEvents: function(){
        $(document).on("click", ".btn_entity_add", App.handleAddparticipant);
        $(document).on("click", ".btn_add_vaccine", App.handleAddvaccine);
        $(document).on("click", ".btn_ParticipantView", App.handleViewParticipant);
        $(document).on("click", ".btn_view_vaccine", App.handleViewVaccine);
    },
    handleAddparticipant:function(){
        console.log("handling participant registration");
        var userName= $("#userName").val();
        var participantAddress= $("#participantAddress").val();
        var participantType= $("#participantType").val();
        console.log(userName +" is "+participantType+ " with address "+participantAddress);
        App.contract.registerParticipant(userName,participantAddress,participantType); 
    },
    handleAddvaccine:function(){
        console.log("handling vaccine addition");
        var vaccineName=$("#vaccineName").val();
        var serialNumber=$("#serialNumber").val();
        var cost=$("#cost").val();
        var mfgTimeStamp=$("#mfgTimeStamp").val();

        console.log(vaccineName+" with serial number " +serialNumber+" cost "+cost+" manufactured at "+mfgTimeStamp);
        App.contract.addVaccine(vaccineName,serialNumber,cost);
    },
    handleViewParticipant:function(){
        console.log("handling view participant");
        var _participantId=$("#_participantId").val();
        console.log(_participantId);
        App.contract.viewParticipant(_participantId).then((data)=>{
            console.log(data);

            var viewParticipantDiv=$("#viewParticipant");
            var viewParticipantTemplate=$("#viewParticipantTemplate");
            for (i=0; i<data.length; i++){
                viewParticipantTemplate.find(".userName").text(data[i].userName);
                viewParticipantTemplate.find(".participantAddress").text(data[i].participantAddress);
                viewParticipantTemplate.find(".participantType").text(data[i].participantType);
                
                viewParticipantDiv.append(viewParticipantTemplate.html());
            }
        });
    },
    handleViewVaccine:function(){
        console.log("handling view vaccine");
        var _vaccine_id=$("#_vaccine_id").val();
        console.log(_vaccine_id);
        App.contract.viewVaccine(_vaccine_id).then((data1)=>{
            // console.log(data1);
            return data1;
        // var viewVaccineDiv= $("#viewVaccine");
        // var viewVaccineTemplate= $("#viewVaccineTemplate");
        // for (i=0; i<data1.length; i++){
        //     viewVaccineTemplate.find(".vaccineName").text(data1[i].vaccineName);
        //     viewVaccineTemplate.find(".serialNumber").text(data1[i].serialNumber);
        //     viewVaccineTemplate.find(".cost").text(data1[i].cost);
        //     viewVaccineTemplate.find(".mfgTimeStamp").text(data1[i].mfgTimeStamp);

        //     viewVaccineDiv.append(viewVaccineTemplate.html());
        // }
        // });
    }
}

$(function () {
    $(window).load(function () {
      App.init();
    });
  });

App={
    contract:{},
    init: async function(){
    console.log("init is called");
    const provider = new ethers.providers.Web3Provider(window.ethereum,"any");

    await provider.send("eth_requestAccounts",[]);

    const signer = provider.getSigner();

    let userAddress = await signer.getAddress();
    
    document.getElementById("wallet").innerText= "Your wallet address is:"+ userAddress;
    const resourceAddress = "0x8626f6940E2eb28930eFb4CeF49B2d1F2C9C1199";

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
        $(document).on("click", "")
    }    
}

$(function () {
    $(window).load(function () {
      App.init();
    });
  });
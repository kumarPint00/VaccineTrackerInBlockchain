//SPDX-License-Identifier:GPL-3.0

pragma solidity ^0.8.0;

contract VaccineTracker{
    uint256 public vaccine_id=0;
    uint256 public participant_id=0;
    address public owner;
   
    struct vaccine{
        string vaccineName;
        string serialNumber;
        uint256 cost;
        uint256 mfgTimeStamp;
    }
mapping (uint256 => vaccine) public vaccines;

    struct partitcipant{
        string userName;
        address participantAddress;
        string participantType;
    }
mapping (uint256 => partitcipant) public participants;

    struct Transit {
        string manufacturers;
        string logistics;
        string suppliers;
        string distributer;
        string hospitals;
    }
mapping(uint256=> Transit) public transit;

    enum Status{
        PACKAGED,
        APPROVED,
        DISPATCHED,
        INTRANSIT,
        UNFIT,
        FITFORUSE
    }
    Status public vaccineStatus;


    event changeVaccineStatus(Status);
    enum location{
        DELHI,
        MUMBAI,
        HYDERABAD,
        PUNE,
        CHENNAI
    }
    location public defaultgeolocation=location.DELHI;
    event changeGeoLocation(location);
    
    constructor()  {
        owner = msg.sender;
        }

function registerParticipant(
                string memory _username,
                address _participantAddress,
                string memory _participantType
                ) public returns(uint256){
                    uint256 participantId=participant_id++;
                    participants[participantId].userName= _username;
                    participants[participantId].participantAddress=_participantAddress;
                    participants[participantId].participantType=_participantType;

                    return participantId;

                }    


function addVaccine(
                    string memory _vaccineName,
                    string memory _serialNumber,
                    uint256 _vaccineCost)  public returns(uint256){
    uint256 vaccineId = vaccine_id++;
    vaccines[vaccineId].vaccineName = _vaccineName;
    vaccines[vaccineId].serialNumber= _serialNumber;
    vaccines[vaccineId].cost=_vaccineCost;
    vaccines[vaccineId].mfgTimeStamp=uint256(block.timestamp);
    
    return vaccineId;
}



function viewParticipant(uint256 _participantId) public view returns(partitcipant memory){
    return participants[_participantId];
}
function userName(uint256 _participantId)public view returns(string memory){
    return participants[_participantId].userName;
}
function viewVaccine(uint256 _vaccine_id) public view returns(vaccine memory){
    return vaccines[_vaccine_id];
}
// function geoLocation(uint256 _vaccine_id) public view returns(uint256){
//     return participantId;
// }
  function geoLocation(uint8 _status) public {
        //Functions to register the GeoLocation of vaccine in transit
        if (_status == 0) {
            vaccineStatus = Status.PACKAGED;
            defaultgeolocation=location.DELHI;
        } else if (_status == 1) {
            require(vaccineStatus == Status.PACKAGED);
            vaccineStatus = Status.APPROVED;
            defaultgeolocation=location.MUMBAI;
        } else if (_status == 2) {
            require(vaccineStatus == Status.APPROVED);
            vaccineStatus = Status.DISPATCHED;
            defaultgeolocation=location.HYDERABAD;
        } else if (_status == 3) {
            require(vaccineStatus == Status.DISPATCHED);
            vaccineStatus = Status.INTRANSIT;
            defaultgeolocation=location.PUNE;
        } else if (_status == 4) {
            require(vaccineStatus == Status.INTRANSIT);
            vaccineStatus = Status.UNFIT;
            defaultgeolocation=location.CHENNAI;
        } else if (_status == 5) {
            require(vaccineStatus == Status.UNFIT);
            vaccineStatus = Status.FITFORUSE;
            defaultgeolocation=location.CHENNAI;
        }

        emit changeVaccineStatus(vaccineStatus);
        emit changeGeoLocation(defaultgeolocation);
    }
function currentgeoLocation()public view returns(Status,location){
    return (vaccineStatus,defaultgeolocation);
}
function currentvaccineStatus() public view returns(Status) {
        //track vaccine status
        return vaccineStatus;
    }



// string public currentOwner;
// event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
// function Currentowner() public view virtual returns (address) {
//         return owner;
//     }
// function _transferOwnership(address newOwner) public {
//         address oldOwner = owner;
//         owner = newOwner;
//         emit OwnershipTransferred(oldOwner, newOwner);
//     }

// function administerOfvaccine(uint256 _status) public returns(string memory){
//     if (_status==0) {
//     vaccineStatus=Status.PACKAGED;
//     currentOwner=="Manufacturer";
//     }
//     else if (_status==1){
//         vaccineStatus=Status.APPROVED;
//         currentOwner="Supplier";
//     }else if (_status==2){
//         vaccineStatus=Status.DISPATCHED;
//         currentOwner="Logistics";
//     }else if (_status==3){
//         vaccineStatus=Status.INTRANSIT;
//         currentOwner="Distributor";
//     }else if (_status==4){
//         vaccineStatus=Status.FITFORUSE;
//         currentOwner="Hospital";
//     }else if (_status==5){
//         vaccineStatus=Status.UNFIT;
//         currentOwner="Hospital";
//     }
//     return currentOwner;

// }


// function currentVaccineStatus(uint256 _vaccine_id) public view returns(){

// }
}
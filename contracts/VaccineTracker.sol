//SPDX-License-Identifier:GPL-3.0

pragma solidity ^0.8.0;

contract VaccineTracker{
    uint256 public vaccine_id=0;
    uint256 public owner_id =0;
    uint256 public participant_id=0;
    struct vaccine{
        string vaccineName;
        string serialNumber;
        address vaccineOwner;
        uint256 cost;
        uint256 mfgTimeStamp;
    }
    struct partitcipant{
        string userName;
        address participantAddress;
        string participantType;
    }
    enum Status{
        PACKAGED,
        APPROVED,
        DISPATCHED,
        INTRANSIT,
        UNFIT,
        FITFORUSE
    }

    Status public vaccineStatus;

mapping (uint256 => vaccine) public vaccines;
mapping (uint256 => partitcipant) public participants;
function addVaccine(uint256 _ownerId,
                    string memory _vaccineName,
                    string memory _serialNumber,
                    uint256 _vaccineCost) public returns(uint256){
    uint256 vaccineId = vaccine_id++;
    vaccines[vaccineId].vaccineName = _vaccineName;
    vaccines[vaccineId].serialNumber= _serialNumber;
    vaccines[vaccineId].vaccineOwner=participants[_ownerId].participantAddress;
    vaccines[vaccineId].cost=_vaccineCost;
    vaccines[vaccineId].mfgTimeStamp=uint256(block.timestamp);
    
    return vaccineId;
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
function viewParticipant(uint256 _participantId) public view returns(string memory, address, string memory){
    return (participants[_participantId].userName,
            participants[_participantId].participantAddress,
            participants[_participantId].participantType);
}
// function geoLocation(uint256 _vaccine_id) public view returns(uint256){
//     return participantId;
// }
function viewVaccine(uint256 _vaccine_id) public view returns(string memory, string memory, address, uint256,uint256){
    return(vaccines[_vaccine_id].vaccineName,
           vaccines[_vaccine_id].serialNumber,
           vaccines[_vaccine_id].vaccineOwner,
           vaccines[_vaccine_id].cost,
           vaccines[_vaccine_id].mfgTimeStamp);
}

// function administerOfvaccine(uint256 _vaccine_id) public returns(string memory, address, string memory){

// }
// function currentVaccineStatus(uint256 _vaccine_id) public view returns(){

// }
}
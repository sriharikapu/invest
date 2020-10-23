// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.6.12;

contract election {

    bool[] castedVoteT;
    bool[] castedVoteF;
    address[] voterT;
    address[] voterF;
    uint256 pointer;
    
      
    mapping (address => uint256) public counter;
    
    uint256 ctime = getTime();
  
    uint256 public enddate;
    bool temp;
//    constructor(uint256 _resultDate, bool _enableVOTEChange) public {
//        enddate = _resultDate;
//        temp = _enableVOTEChange;
//
//   }    

    constructor() public {
         enddate = 1603432416;
	 temp = false;
    }

    function vote(bool yourVote) public payable returns(bool){
        bool _yourVote = yourVote;
        if((temp=true)&&(ctime<=enddate)){
            if(_yourVote==true){
                if((_checkCastedF(msg.sender)==true)&&_checkCastedT(msg.sender)==true) {
                    //
                } else if ((_checkCastedF(msg.sender)==false)&&(_checkCastedT(msg.sender)==true)) {
                    //
                } else if ((_checkCastedF(msg.sender)==true)&&(_checkCastedT(msg.sender)==true)) {
                    //
                } else if ((_checkCastedF(msg.sender)==false)&&(_checkCastedT(msg.sender)==false)){
                    voterT.push(msg.sender);
                    castedVoteT.push(_yourVote);
                }
            } else if (_yourVote==false) {
                if((_checkCastedF(msg.sender)==true)&&(_checkCastedT(msg.sender)==false)) {
                  //
                } else if ((_checkCastedF(msg.sender)==false)&&(_checkCastedT(msg.sender)==true)) {
                    //
                } else if ((_checkCastedF(msg.sender)==true)&&(_checkCastedT(msg.sender)==true)) {
                    //
                } else if ((_checkCastedF(msg.sender)==false)&&(_checkCastedT(msg.sender)==false)){
                    voterF.push(msg.sender);
                    castedVoteF.push(_yourVote);
                }          
            }
        } else {
            uint256 currentCount = findCount(msg.sender);
            require(ctime<=enddate);
            require(currentCount<1);
            if(_yourVote==true){
                castedVoteT.push(_yourVote);
                voterT.push(msg.sender);
                counter[msg.sender] += 2;                
            } else {
                castedVoteF.push(_yourVote);
                voterF.push(msg.sender);
                counter[msg.sender] += 2;                
            }
        }
    }
    

    function getTime () internal view returns(uint256 time){
        return block.timestamp - 30 days;
    }
    
    function findCount (address _uaddr) internal view returns(uint256){
        return counter[_uaddr];
    }
    

    function CurrentResult() public view returns (string memory) {
        uint256 tz = tVoterCount();
        uint256 fz = fVoterCount();
        if(tz>fz){
            return "T-WON";
        }else if(tz==fz){
            return "TIE";
        }else{
            return "F-WON";
        }
    }
    
    function FinalResult() public view returns (string memory) {
        require(ctime>=enddate);
        uint256 ty = tVoterCount();
        uint256 fy = fVoterCount();
        if(ty>fy){
            return "FINAL-T-WON";
        }else if(ty==fy){
            return "FINAL-TIED";
        }else if(ty<fy) {
            return "FINAL-F-WON";
        }else{
            return "ENDDATE-NOTARRIVED";
        }
    }
    
    
        
    function _checkCastedF(address _addr) internal view returns(bool) {
        for(uint i=0;i<voterF.length;i++){
            if(voterF[i]==_addr){
                return true;  
            } else {
                return false;
            }
        }
    }
    
    
    function _checkCastedT(address _addr) internal view returns(bool) {
        for(uint j=0;j<voterT.length;j++){
            if(voterT[j]==_addr){
                return true;  
            } else {
                return false;
            }
        }
    }
    
        
    
    function tVoterCount() public view returns (uint256){
        uint256 t = voterT.length;
        return t;
    }
    
    
    function fVoterCount() public view returns (uint256){
        uint256 f = voterF.length;
        return f;
    }
    

    function tVoters() public view returns (address  [] memory){
        return voterT;
    }
    
    function fVoters() public view returns (address  [] memory){
        return voterF;
    }
}

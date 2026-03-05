pragma circom 2.0.0;
include "./commitment_hasher.circom";

template BatchDeposit8() {
    // Private inputs (8 deposits)
    signal input secret[8][256];
    signal input nullifier[8][256];
    
    // Public outputs
    signal output commitment[8];
    signal output nullifierHash[8];
    
    component cHasher[8];
    
    for (var t = 0; t < 8; t++) {
        cHasher[t] = CommitmentHasher();
        
        for (var i = 0; i < 256; i++) {
            cHasher[t].secret[i] <== secret[t][i];
            cHasher[t].nullifier[i] <== nullifier[t][i];
        }
        
        commitment[t] <== cHasher[t].commitment;
        nullifierHash[t] <== cHasher[t].nullifierHash;
    }
}

component main = BatchDeposit8();
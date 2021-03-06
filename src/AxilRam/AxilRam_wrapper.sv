/*
   Copyright 2020 Scott Teal

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

module AxilRam_wrapper #(
    parameter MEM_W = 10
)
(
    // Global Signals
    input  logic aclk,
    input  logic aresetn,
    // Write Address Channel
    input  logic [31:0] awAddr,
    input  logic [2:0] awProt,
    input  logic awValid,
    output logic awReady,
    // Write Data Channel
    input  logic [31:0] wData,
    input  logic [3:0] wStrb,
    input  logic wValid,
    output logic wReady,
    // Write Response Channel
    output logic [1:0] bResp,
    output logic bValid,
    input  logic bReady,
    // Read Address Channel
    input  logic [31:0] arAddr,
    input  logic [2:0] arProt,
    input  logic arValid,
    output logic arReady,
    // Read Data Channel
    output logic [31:0] rData,
    output logic [1:0] rResp,
    output logic rValid,
    input  logic rReady
);
timeunit 1ns;
timeprecision 10ps;

AxiLite #(32) bus (aclk, aresetn);

always_comb begin
    // Write Address Channel
    bus.awAddr  = awAddr;
    bus.awProt  = awProt;
    bus.awValid = awValid;
    awReady     = bus.awReady;
    // Write Data Channel
    bus.wData  = wData;
    bus.wStrb  = wStrb;
    bus.wValid = wValid;
    wReady     = bus.wReady;
    // Write Response Channel
    bResp      = bus.bResp;
    bValid     = bus.bValid;
    bus.bReady = bReady;
    // Read Address Channel
    bus.arAddr  = arAddr;
    bus.arProt  = arProt;
    bus.arValid = arValid;
    arReady     = bus.arReady;
    // Read Data Channel
    rData      = bus.rData;
    rResp      = bus.rResp;
    rValid     = bus.rValid;
    bus.rReady = rReady;
end

AxilRam #(
    .MEM_W(MEM_W)
)
wrappedUnit (
    .*
);

endmodule

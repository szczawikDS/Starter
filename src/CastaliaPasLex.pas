{-----------------------------------------------------------------------------
Based on mwPasLex, written by Martin Waldenburg.
-----------------------------------------------------------------------------}

unit CastaliaPasLex;

interface

uses
  SysUtils, CastaliaPasLexTypes;

var
  Identifiers: array[#0..#255] of ByteBool;

type
  TmwBasePasLex = class(TObject)
  private
    fOrigin: PChar;
    fProcTable: array[#0..#255] of procedure of object;
    Run: Integer;
    fTokenPos: Integer;
    fLineNumber: Integer;
    FTokenID: TptTokenKind;
    fLinePos: Integer;

	  function KeyHash: Integer;
    function GetPosXY: TTokenPoint;
    function IdentKind: TptTokenKind;
    procedure SetRunPos(Value: Integer);
    procedure MakeMethodTables;
    procedure CommaProc;
    procedure CRProc;
    procedure EqualProc;
    procedure IdentProc;
	  procedure LFProc;
    procedure NullProc;
    procedure NumberProc;
    procedure SlashProc;
    procedure SpaceProc;
    procedure SquareCloseProc;
    procedure SquareOpenProc;
    procedure StarProc;
    procedure SymbolProc;
    procedure UnknownProc;
    function GetToken: string;
    function GetTokenLen: Integer;
    function GetIsJunk: Boolean;
    function GetIsSpace: Boolean;
    procedure DoProcTable(AChar: Char);
    function IsIdentifiers(AChar: Char): Boolean;
  protected
    procedure SetOrigin(NewValue: PChar); virtual;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Next;
    procedure NextID(ID: TptTokenKind);
    procedure NextNoJunk;
    procedure NextNoSpace;
    procedure Init;

	  property IsJunk: Boolean read GetIsJunk;
    property IsSpace: Boolean read GetIsSpace;
    property LineNumber: Integer read fLineNumber write fLineNumber;
    property LinePos: Integer read fLinePos write fLinePos;
    property Origin: PChar read fOrigin write SetOrigin;
    property PosXY: TTokenPoint read GetPosXY;
    property RunPos: Integer read Run write SetRunPos;
    property Token: string read GetToken;
    property TokenLen: Integer read GetTokenLen;
    property TokenPos: Integer read fTokenPos;
    property TokenID: TptTokenKind read FTokenID;
  end;

  TmwPasLex = class(TmwBasePasLex)
  private
    fAheadLex: TmwBasePasLex;
    function GetAheadToken: string;
    function GetAheadTokenID: TptTokenKind;
  protected
    procedure SetOrigin(NewValue: PChar); override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure InitAhead;
    procedure AheadNext;
    property AheadLex: TmwBasePasLex read fAheadLex;
    property AheadToken: string read GetAheadToken;
    property AheadTokenID: TptTokenKind read GetAheadTokenID;
  end;

implementation

uses Windows;

procedure MakeIdentTable;
var
  I : Char;
begin
  for I := #0 to #255 do
  begin
    case I of
      '_', '0'..'9', 'a'..'z', 'A'..'Z': Identifiers[I] := True;
    else Identifiers[I] := False;
    end;
  end;
end;

function TmwBasePasLex.GetPosXY: TTokenPoint;
begin
  Result.X:= FTokenPos - FLinePos;
  Result.Y:= FLineNumber;
end;

function TmwBasePasLex.KeyHash: Integer;
begin
  Result := 0;
  while IsIdentifiers(fOrigin[Run]) do
    inc(Run);
end;

function TmwBasePasLex.IdentKind: TptTokenKind;
begin
  KeyHash;
  Result := ptIdentifier;
end;

procedure TmwBasePasLex.MakeMethodTables;
var
  I: Char;
begin
  for I := #0 to #255 do
    case I of
       #0: fProcTable[I] := NullProc;
	    #10: fProcTable[I] := LFProc;
	    #13: fProcTable[I] := CRProc;
      #1..#9, #11, #12, #14..#32:
           fProcTable[I] := SpaceProc;
      #39: fProcTable[I] := SymbolProc;
      '0'..'9': fProcTable[I] := NumberProc;
      'A'..'Z', 'a'..'z', '_':
           fProcTable[I] := IdentProc;
      '!', '"', '%', '&', '('..'/', ':'..'@', '['..'^', '`', '~':
        begin
          case I of
            '*': fProcTable[I] := StarProc;
            ',': fProcTable[I] := CommaProc;
            '/': fProcTable[I] := SlashProc;
            '=': fProcTable[I] := EqualProc;
            '[': fProcTable[I] := SquareOpenProc;
            ']': fProcTable[I] := SquareCloseProc;
          else fProcTable[I] := SymbolProc;
          end;
        end;
    else fProcTable[I] := UnknownProc;
    end;
end;

constructor TmwBasePasLex.Create;
begin
  inherited Create;
  fOrigin := nil;
  MakeMethodTables;
end;

destructor TmwBasePasLex.Destroy;
begin
  fOrigin := nil;
  inherited Destroy;
end;

procedure TmwBasePasLex.DoProcTable(AChar: Char);
begin
  if AChar <= #255 then
    fProcTable[AChar]
  else
  begin
    IdentProc;
  end;
end;

procedure TmwBasePasLex.SetOrigin(NewValue: PChar);
begin
  fOrigin := NewValue;
  Init;
  Next;
end;

procedure TmwBasePasLex.SetRunPos(Value: Integer);
begin
  Run := Value;
  Next;
end;

procedure TmwBasePasLex.CommaProc;
begin
  Inc(Run);
  fTokenID := ptComma;
end;

procedure TmwBasePasLex.CRProc;
begin
  fTokenID := ptCRLF;

  if FOrigin[Run + 1] = #10 then
    Inc(Run,2)
  else
    Inc(Run);

  Inc(fLineNumber);
  fLinePos := Run;
end;

procedure TmwBasePasLex.EqualProc;
begin
  Inc(Run);
  fTokenID := ptEqual;
end;

procedure TmwBasePasLex.IdentProc;
begin
  fTokenID := IdentKind;
end;

function TmwBasePasLex.IsIdentifiers(AChar: Char): Boolean;
begin
  if AChar <= #255 then
    Result := Identifiers[AChar]
  else
    Result := True;
end;

procedure TmwBasePasLex.LFProc;
begin
  fTokenID := ptCRLF;
  Inc(Run);
  Inc(fLineNumber);
  fLinePos := Run;
end;

procedure TmwBasePasLex.NullProc;
begin
  fTokenID := ptNull;
end;

procedure TmwBasePasLex.NumberProc;
begin
  Inc(Run);
  fTokenID := ptInteger;
  while CharInSet(FOrigin[Run],['0'..'9', '.', 'e', 'E']) do
  begin
    if FOrigin[Run] = '.' then
      if FOrigin[Run + 1] = '.' then
        Break
      else
        FTokenID := ptFloat;

    Inc(Run);
  end;
end;

procedure TmwBasePasLex.SlashProc;
begin
  case FOrigin[Run + 1] of
    '/':
      begin
        Inc(Run, 2);
        fTokenID := ptSlashesComment;
        while FOrigin[Run] <> #0 do
        begin
          case FOrigin[Run] of
            #10, #13: break;
          end;
          Inc(Run);
        end;
      end;
  else
    begin
      Inc(Run);
      fTokenID := ptSlash;
    end;
  end;
end;

procedure TmwBasePasLex.SpaceProc;
begin
  Inc(Run);
  fTokenID := ptSpace;
  while CharInSet(FOrigin[Run],[#1..#9, #11, #12, #14..#32]) do
    Inc(Run);
end;

procedure TmwBasePasLex.SquareCloseProc;
begin
  Inc(Run);
  fTokenID := ptSquareClose;
end;

procedure TmwBasePasLex.SquareOpenProc;
begin
  Inc(Run);
  fTokenID := ptSquareOpen;
end;

procedure TmwBasePasLex.StarProc;
begin
  Inc(Run);
  fTokenID := ptStar;
end;

procedure TmwBasePasLex.SymbolProc;
begin
  Inc(Run);
  fTokenID := ptSymbol;
end;

procedure TmwBasePasLex.UnknownProc;
begin
  Inc(Run);
  fTokenID := ptUnknown;
end;

procedure TmwBasePasLex.Next;
begin
  fTokenPos := Run;
  DoProcTable(fOrigin[Run]);
end;


function TmwBasePasLex.GetIsJunk: Boolean;
begin
  result := IsTokenIDJunk(FTokenID);
end;

function TmwBasePasLex.GetIsSpace: Boolean;
begin
  Result := fTokenID in [ptCRLF, ptSpace];
end;

function TmwBasePasLex.GetToken: string;
begin
  SetString(Result, (FOrigin + fTokenPos), GetTokenLen);
end;

function TmwBasePasLex.GetTokenLen: Integer;
begin
  Result := Run - fTokenPos;
end;

procedure TmwBasePasLex.NextID(ID: TptTokenKind);
begin
  repeat
    if fTokenID = ptNull then
      Break
    else
      Next;
  until fTokenID = ID;
end;

procedure TmwBasePasLex.NextNoJunk;
begin
  repeat
    Next;
  until not IsJunk;
end;

procedure TmwBasePasLex.NextNoSpace;
begin
  repeat
    Next;
  until not IsSpace;
end;

procedure TmwBasePasLex.Init;
begin
  fLineNumber := 0;
  fLinePos := 0;
  Run := 0;
end;

{ TmwPasLex }

constructor TmwPasLex.Create;
begin
  inherited Create;
  fAheadLex := TmwBasePasLex.Create;
end;

destructor TmwPasLex.Destroy;
begin
  fAheadLex.Free;
  inherited Destroy;
end;

procedure TmwPasLex.SetOrigin(NewValue: PChar);
begin
  inherited SetOrigin(NewValue);
  fAheadLex.SetOrigin(NewValue);
end;

procedure TmwPasLex.AheadNext;
begin
  fAheadLex.NextNoJunk;
end;

function TmwPasLex.GetAheadToken: string;
begin
  Result := fAheadLex.Token;
end;

function TmwPasLex.GetAheadTokenID: TptTokenKind;
begin
  Result := fAheadLex.TokenID;
end;

procedure TmwPasLex.InitAhead;
begin
  fAheadLex.RunPos := RunPos;
  FAheadLex.fLineNumber := FLineNumber;
  FAheadLex.FLinePos := FLinePos;

  while fAheadLex.IsJunk do
    fAheadLex.Next;
end;

initialization
  MakeIdentTable;
end.


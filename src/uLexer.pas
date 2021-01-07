unit uLexer;

interface

uses CastaliaPasLex, CastaliaPasLexTypes, uStructures, Classes;

type
  TLexer = class
  public
    Lexer:TmwPasLex;
    constructor Create;
    destructor Destroy; override;
  protected
    function GetToken: string; overload;
    function GetToken(const Params: TStringList): string; overload;
    function GetToken(const Stoppers:TptTokenKinds): string; overload;
    procedure SkipComment;
  end;

implementation

uses SysUtils, uMain;

constructor TLexer.Create;
begin
  {$IFDEF DEBUG}
  //Measure;
  {$ENDIF}
  Lexer := TmwPasLex.Create;
end;

destructor TLexer.Destroy;
begin
  Lexer.Free;
end;

function TLexer.GetToken:string;
begin
  Result := '';
  while (not Lexer.IsSpace) and (Lexer.TokenID <> ptNull) do
  begin
    Result := Result + Lexer.Token;
    Lexer.Next;
  end;
end;

function TLexer.GetToken(const Stoppers:TptTokenKinds):string;
begin
  Result := '';
  while (not (Lexer.TokenID in Stoppers)) and (Lexer.TokenID <> ptNull) do
  begin
    Result := Result + Lexer.Token;
    Lexer.Next;
  end;
end;

function TLexer.GetToken(const Params:TStringList):string;
begin
  try
    if Lexer.Token = '(' then
    begin
      Lexer.Next;
      Result := Params[StrToInt(Lexer.Token[2])-1];
    end
    else
      Result := GetToken;
  except
    Main.Errors.Add('B³¹d prztwarzania elementu fizyki. Token: ' + Lexer.Token);
  end;
end;

procedure TLexer.SkipComment;
begin
  Lexer.InitAhead;
  if Lexer.AheadTokenID = ptStar then
  begin
    while not ((Lexer.TokenID = ptStar) and (Lexer.AheadTokenID = ptSlash)) and (Lexer.TokenID <> ptNull) do
    begin
      Lexer.NextNoJunk;
      Lexer.AheadNext;
    end;
  end;
end;

end.

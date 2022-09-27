{
  Starter
  Copyright (C) 2019-2021 Damian Skrzek (szczawik)

  This file is part of Starter.

  Starter is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 3 of the License, or
  (at your option) any later version.

  Starter is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with Starter.  If not, see <http://www.gnu.org/licenses/>.
}

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
    procedure NextIDs(const IDs:TptTokenKinds);
    procedure SkipComment;
  end;

implementation

uses SysUtils, uMain, uUtilities;

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

procedure TLexer.NextIDs(const IDs: TptTokenKinds);
begin
  repeat
    if Lexer.TokenID = ptNull then
      Break
    else
      Lexer.Next;
  until Lexer.TokenID in IDs;
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
    Util.Log.Add('B³¹d prztwarzania elementu fizyki. Token: ' + Lexer.Token);
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

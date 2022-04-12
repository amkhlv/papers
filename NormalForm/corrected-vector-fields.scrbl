#lang scribble/base
@(require racket scribble/core scribble/base scribble/html-properties)
@(require "defs.rkt" bystroTeX/common bystroTeX/slides (for-syntax bystroTeX/slides_for-syntax))
@; ---------------------------------------------------------------------------------------------------
@; User definitions:
@(bystro-set-css-dir (build-path (find-system-path 'home-dir) "a" "git" "amkhlv" "profiles" "writeup"))
@(define bystro-conf   
   (bystro (bystro-connect-to-server (build-path (find-system-path 'home-dir) ".config" "amkhlv" "latex2svg.xml"))
           "corrected-vector-fields/formulas.sqlite"  ; name for the database
           "corrected-vector-fields" ; directory where to store image files of formulas
           25  ; formula size
           (list 255 255 255) ; formula background color
           (list 0 0 0) ; formula foreground color
           2   ; automatic alignment adjustment
           0   ; manual alignment adjustment
           ))
@(define singlepage-mode #f)
@(bystro-def-formula "formula-enormula-humongula!")

@(define (high) (bystro-bg 255 255 255))
@;(define-restore-colors reset bystro-conf)


@(require bystroTeX/bibtex truques/truques)

@(define build-for-local  (bystro-cl-flag? "local"))
@(define build-for-server (bystro-cl-flag? "server"))


@(define
   (marg #:scale s #:dir d #:filter f)
   (bystro-margin-note
    (when build-for-local
      (autolist-svgs
       #:scale s
       #:dir d
       #:ncols 1
       #:showdir #f
       #:filter f
       )
      )
    (when build-for-server
      (autolist
       #:exts '(svg)
       #:dir d
       #:filter f
       #:output (lambda (x)
                  `(,(hyperlink
                      (path->string x)
                      (image
                       #:scale s
                       (find-relative-path
                        (current-directory)
                        (path->complete-path (build-path d x))))
                      )))
       )
      )
    )
   )

@title[#:style '(no-toc no-sidebar)]{Correction to Vector Fields}

@bystro-source[]

@bystro-ribbon[]

@bystro-abstract{
                 Pure spinor formalism implies that supergravity equations in space-time are equivalent
                 to the requirement that the worldsheet sigma-model satisfies certain properties.
                 Here we point out that one of these
                 properties has a particularly transparent geometrical interpretation. 
                 Namely, there exists an odd nilpotent vector field on some singular supermanifold,
                 naturally associated to space-time. All supergravity fields are
                 encoded in this vector field, as coefficients in its normal form. The nilpotence
                 implies, modulo some zero modes, that they satisfy the SUGRA equations of motion.
                 }

@bystro-toc[]

@(bystro-scrbl-only
  (when build-for-local
    (autolist-svgs
     #:dir "corrected-vector-fields/svgs"
     #:filter (λ (p) #t)))
  )

@bystro-ribbon[]


@use-LaTeX-preamble{

\newcommand{\p}{\partial}
\newcommand{\pb}{\bar\partial}
\newcommand{\ph}{{\widehat p}}
\newcommand{\zb}{{\bar z}}
\newcommand{\N}{{\nabla}}
\newcommand{\Nb}{{\overline \nabla}}
\newcommand{\Oc}{{\mathcal O}}
\newcommand{\C}{{\mathbb C}}
\newcommand{\Nh}{{\widehat \nabla}}
\newcommand{\a}{{\alpha}}
\newcommand{\ah}{{\widehat\alpha}}
\newcommand{\b}{{\beta}}
\newcommand{\bh}{{\widehat\beta}}
\newcommand{\d}{{\delta}}
\newcommand{\e}{{\epsilon}}
\newcommand{\ve}{{\varepsilon}}
\newcommand{\g}{{\gamma}}
\newcommand{\gh}{{\widehat \gamma}}
\newcommand{\G}{{\Gamma}}
\newcommand{\i}{{\iota}}
\newcommand{\l}{{\lambda}}
\newcommand{\lh}{{\widehat\lambda}}
\newcommand{\L}{{\Lambda}}
\newcommand{\m}{{\mu}}
\newcommand{\n}{{\nu}}
\newcommand{\o}{{\omega}}
\newcommand{\oh}{{\widehat\omega}}
\newcommand{\O}{{\Omega}}
\newcommand{\Oh}{{\widehat\Omega}}
\newcommand{\s}{{\sigma}}
\newcommand{\S}{{\Sigma}}
\newcommand{\t}{{\theta}}
\newcommand{\th}{{\widehat\theta}}
\newcommand{\Qh}{{\widehat Q}}
\newcommand{\eh}{{\widehat e}}
\newcommand{\omegaLLL}{{\scriptstyle \left[\begin{array}{cc} \!\!\!\! & \!\!L\!\! \cr \!\!L\!\! & \!\!L\!\! \end{array}\right]}}
\newcommand{\omegaLRR}{{\scriptstyle \left[\begin{array}{cc} \!\!\!\! & \!\!R\!\! \cr \!\!L\!\! & \!\!R\!\! \end{array}\right]}}
\newcommand{\omegaRLL}{{\scriptstyle \left[\begin{array}{cc} \!\!\!\! & \!\!L\!\! \cr \!\!R\!\! & \!\!L\!\! \end{array}\right]}}
\newcommand{\omegaRRR}{{\scriptstyle \left[\begin{array}{cc} \!\!\!\! & \!\!R\!\! \cr \!\!R\!\! & \!\!R\!\! \end{array}\right]}}
\newcommand{\xiLLL}{{\scriptstyle\left\{\!\begin{array}{cc}  & \!\!L\!\! \cr \!\!L\!\! & \!\!L\!\! \end{array}\right\}}}
\newcommand{\xiLRR}{{\scriptstyle\left\{\!\begin{array}{cc}  & \!\!R\!\! \cr \!\!L\!\! & \!\!R\!\!  \end{array}\right\}}}
\newcommand{\xiRRR}{{\scriptstyle\left\{\!\begin{array}{cc}  & \!\!R\!\! \cr \!\!R\!\! & \!\!R\!\! \end{array}\right\}}}
\newcommand{\xiRLL}{{\scriptstyle\left\{\!\begin{array}{cc}  & \!\!L\!\! \cr \!\!R\!\! & \!\!L\!\!  \end{array}\right\}}}
}


@page["Introduction" #:tag "Introduction" #:showtitle #t]



In the low energy limit of superstring theory,
spacetime fields satisfy supergravity (SUGRA) equations of motion,
which are super-analogues of the Einstein equations.
It is one of the main principles of string theory, that these target space equations of motion
are equivalent to the BRST invariance of the string worldsheet theory. When they are satisfied,
the space of fields is an infinite-dimensional @f{Q}-manifold
(a manifold with an odd nilpotent vector field @cite{Alexandrov:1995kv}).
But in the case of @bold{pure spinor string}, the sigma-model also defines a @bold{finite-dimensional} @f{Q}-manifold.
Indeed,
the action of the BRST operator on matter fields and pure spinor ghosts does not contain worldsheet derivatives.
(The worldsheet derivatives will appear when we consider the action on the conjugate momenta
     to matter fields and pure spinor ghosts, but they can be considered separately.)
This means that, if we think of the pure spinor ghosts as part of target space, the BRST operator defines
@bold{on the target space} an odd nilpotent vector field, which we denote @f{Q}. In other words,
the target space of the pure spinor sigma-model (a finite-dimenisional supermanifold) is a @f{Q}-manifold.
Moreover, in generic space-time (for example in @f{AdS_5\times S^5}, but not in flat space-time)
the energy-momentum tensor and the @f{b}-ghost can also be interpreted as symmetric tensors
on the target space (see @cite{Mikhailov:2017mdo}).



How to classify a generic odd nilpotent vector field @f{Q}? A vector field can usually be ``simplified'' by
a clever choice of coordinates. This is called  ``normal form''.
If a vector field is non-vanishing,
one can choose coordinates so that the it is @f{\partial\over\partial\theta} where @f{\theta} is
one of fermionic coordinates. If @f{Q} vanishes at some point, then the normal form would be
(in the notations of @cite{Alexandrov:1995kv}) @f{\eta^a {\partial\over\partial x^a}}.
But in out case, the target space is not a smooth supermanifold, because pure spinor ghosts live on a cone.
The vector @f{Q} vanishes precisely at the singular locus, and the problem of classification of normal forms is
a nontrivial cohomological computation. This is what we will do in this paper. We will find that
the space of equivalence classes of odd nilpotent vector fields in a vicinity of the singular locus
is equivalent to the space of the classical SUGRA solutions.
This is true modulo some @bold{``zero modes''} --- a finite-dimensional subspaces of soultions (see @cite{Mikhailov:2014qka})
which we ignore in this paper.

Some details of our computations can be found in the
@hyperlink["https://andreimikhailov.com/math/vector-fields/index.html"]{HTML version of this paper}.


@bystro-local-toc[]


@subpage[1 @elem{Definition of @f{M}} #:tag "sec:IntroM"]

The particular singularity which we are interested in can be described as follows.
Consider the space @f{M} with bosonic coordinates @f{x^m} (@f{m} running from 1 to 10) and
@f{\lambda_L^{\alpha}}, @f{\lambda_R^{\hat{\alpha}}} (@f{\alpha} and @f{\hat{\alpha}} both running from 1 to 16),
and fermionic @f{\theta_L^{\alpha}} and @f{\theta_R^{\hat{\alpha}}}, with the constraint:
@e[#:label "IntroPSCone"
   ]{
     \lambda_L^{\alpha}\Gamma_{\alpha\beta}^m\lambda_L^{\beta} =
     \lambda_R^{\hat{\alpha}}\Gamma_{\hat{\alpha}\hat{\beta}}^m\lambda_R^{\hat{\beta}} = 0
     }
where @f{\Gamma^m} are ten-dimensional gamma-matrices. These constraints are called ``pure spinor constraints''.
We understand Eqs. (@ref{IntroPSCone}) as specifying the singular
locus in @f{M}, from the point of view  of differential geometry. All we need from these
equations is to know how @f{M} deviates from being smooth.
The singular locus is the tip of the cone (@ref{IntroPSCone}):
@e[#:label "SingularityLocus"]{
   \lambda_L = 0 \mbox{ \tt\small or } \lambda_R = 0
   }
Pure spinor constraints (@ref{IntroPSCone}) are invariant under the action of the group
@e[#:label "DefG"
   ]{
     G = {\rm Spin}(10)_L\times {\bf C}^{\times}_L \times {\rm Spin}(10)_R\times {\bf C}^{\times}_R
     }
The diagonal
@e[
   #:label "GhostNumber"
   ]{
     {\bf C}^{\times}\subset {\bf C}_L^{\times}\times {\bf C}_R^{\times}
     }
is called ``ghost number symmetry''. Infinitesimal ghost number symmetry is generated by
@f{\lambda_L^{\alpha}{\partial\over\partial\lambda_L^{\alpha}} +
                   \lambda_R^{\hat{\alpha}}{\partial\over\partial\lambda_R^{\hat{\alpha}}}}.
                          
Consider an odd vector field @f{Q} satisfying the following properties:
@(itemlist
  @item{@f{Q} has ghost number 1, @italic{i.e.}:
        @e[#:label "QhasGhostNumberOne"]{
           \left[\lambda_L^{\alpha}{\partial\over\partial\lambda_L^{\alpha}} +
                           \lambda_R^{\hat{\alpha}}{\partial\over\partial\lambda_R^{\hat{\alpha}}}\;,\;Q\right] = Q
           }
          }
  @item{@f{Q^2 = 0}}
  @item{@f{Q} is ``smooth'' in the sense that it can be
          obtained as a restriction to the cone (@ref{IntroPSCone}) of a smooth (but not nilpotent)
          vector field
          in the space parametrized by unconstrained @f{x,\theta,\lambda}}
  @item{@f{Q} is zero at @f{\lambda_L = \lambda_R = 0} }
)
We want to classify such vector fields modulo coordinate transformations.
Coordinate transformations are supermaps @f{(x,\lambda,\theta)\mapsto (\tilde{x},\tilde{\lambda},\tilde{\theta})}
such that @f{\tilde{\lambda}} satisfy the same constraints (@ref{IntroPSCone}).

Such a vector field is one of the geometrical structures associated to the pure spinor
superstring worldsheet theory @cite{Berkovits:2001ue},@cite{Guttenberg:2008ic}.
In particular, flat background (empty ten-dimensional spacetime) corresponds to @f{Q=Q^{\rm flat}}:
@(align
  r.l.n
  `(@,f{Q^{\rm flat} \;=\;} @,f{Q^{\rm flat}_L + Q^{\rm flat}_R \mbox{ \tt\small where: }} @,label{QFlat})
  `(@,f{Q_L^{\rm flat}\;=\;}
       @,f{\lambda^{\alpha}_L{\partial\over\partial\theta^{\alpha}_L} +
                   (\lambda^{\alpha}_L\Gamma_{\alpha\beta}^m\theta^{\beta}_L)
                   {\partial\over\partial x^m}}
       "")
  `(@,f{Q_R^{\rm flat}\;=\;}
       @,f{\lambda^{\hat{\alpha}}_R{\partial\over\partial\theta^{\hat{\alpha}}_R} +
                    (\lambda^{\hat{\alpha}}_R\Gamma_{\hat{\alpha}\hat{\beta}}^m\theta^{\hat{\beta}}_R)
                    {\partial\over\partial x^m}}
       "")
)
String worldsheet
theory also has, besides @f{Q}, some other structures which are less geometrically transparent
(various couplings in the string worldsheet sigma-model). All these structures should satisfy certain
consistency conditions. 
@(itemlist
  @item{
        @bold{Question:} is it true, that just a nilpotent vector field @f{Q} already
        includes, as various coefficients in its normal form, all the supergravity fields, and the supergravity
        equations of motion are automatically satisfied (@italic{i.e.} follow from @f{Q^2 = 0})?
        }
  )
This may be false in two ways. First, it could be that some supergravity fields do not
enter as coefficients in the normal form of @f{Q}
(@italic{i.e.} they would only appear as some couplings in the sigma-model, but would not enter in @f{Q}).
Second, it could be that just @f{Q^2 = 0} would not be enough to impose SUGRA equations
of motion (@italic{i.e.} one would have to also require the @f{Q}-invariance of the
                  worldsheet sigma-model action).


@subpage[1 "Our results" #:tag "sec:IntroResults"]

In this paper we will derive the normal form of @f{Q} as a deformation of @f{Q^{\rm flat}}:
@e[#:label "ExpansionOfQAroundFlatSpace"
   ]{
     Q = Q^{\rm flat} + \epsilon Q_1 + \epsilon^2 Q_2 + \ldots
     }
Our analysis will be restricted to the terms linear in @f{\epsilon} (@italic{i.e.} @f{Q_1}).
It turns out that @f{Q_1} is parameterized by some tensor fields satisfying certain
hyperbolic partial differential equations. These fields are in one-to-one correspondence
with the fields of the Type II SUGRA, and our hyperbolic equations are the equations of motion
of the linearized Type II SUGRA.

It is useful to compare to the pure spinor description of the super-Yang-Mills equations.
The super-Yang-Mills equations
are equivalent to having an odd nilpotent operator:
@e[#:label "QSYM"
   ]{
     Q_{\rm SYM} =
     \lambda^{\alpha}
     \left(
           {\partial\over\partial\theta^{\alpha}} +
           \Gamma_{\alpha\beta}^m \theta^{\beta}{\partial\over\partial x^m}
           + A^a_{\alpha}(x,\theta){\bf t}_a
           \right)
     }
where @f{{\bf t}_a} are generators of the gauge group, and @f{A^a_{\alpha}(x,\theta)} is vector potential.
Zero solution corresponds to @f{A_{\alpha} = 0}. In this sense, the SYM solutions can be
considered as deformations of the differential operator:
@e{
   Q_{\rm SYM}^{(0)} = 
     \lambda^{\alpha}
     \left(
           {\partial\over\partial\theta^{\alpha}} +
           \Gamma_{\alpha\beta}^m \theta^{\beta}{\partial\over\partial x^m}
           \right)
     }
where the leading symbol (@italic{i.e.} the derivatives) remains undeformed.
Here we consider, instead, the deformations of the leading symbol.
                                       

@subpage[1 @elem{Relation to partial @f{G}-structures} #:tag "GStructures"]

The variables @f{\lambda_L} and @f{\lambda_R} parametrize the normal direction to the
singularity locus @f{Z\subset M}:
@e{
   i\;:\; Z\rightarrow M
   }
The first infinitesimal neighborhood is a bundle
over @f{Z} with the fiber @f{C_L\times C_R} --- the product of two cones.
Filling the cones, we obtain a vector bundle over @f{Z} with the fiber @f{V = {\bf C}^{32}}.
The vector field @f{Q} is power series in @f{\lambda_L,\lambda_R}, with zero at the tip of @f{C_L\times C_R}.
The derivative of @f{Q} at the zero locus defines a linear map:
@e{
   Q_*\;:\; V\rightarrow i^* TM
   }
This map is not an isomorphism, since the image of @f{Q_*} only covers a @f{(0|32)}-dimensional
subbundle of @f{TZ}. We can interpret @f{M} as  @f{(C_L\times C_R)\times_G \widehat{Z}}
where @f{\widehat{Z}} is a partial frame bundle of @f{Z} and  @f{G} is given by Eq. (@ref{DefG}).
It was shown in @cite{Mikhailov:2015sva} that @f{Q} defines a connection in a partial
@f{G}-structure on @f{Z} with some constraints on torsion, modulo some equivalence relation.

The relation to previous work on SUGRA constraints 
@cite{Nilsson:1981bn},
@cite{Howe:1983sra},
@cite{Witten:1985nt},
@cite{Shapiro:1986xp}, 
@cite{Chau:1988sm}, 
@cite{Bergshoeff:1990mr},
@cite{Bergshoeff:1991ei}, 
@cite{Howe:1991bx},
@cite{Howe:1991mf}
can be established along these lines.


@subpage[1 "Divergence of a nilpotent vector field" #:tag "sec:Divergence"]

Let us fix some volume form @f{\mbox{vol}}, an integral form on @f{M}.
Then we can consider, for any vector field @f{V}, its divergence @f{\mbox{div}\, V}.
This is by definition the Lie derivative of @f{\mbox{vol}} along @f{V}:
@e{
   {\cal L}_V\mbox{vol} = (\mbox{div}\,V)\mbox{vol}
   }
In particular, for a nilpotent odd vector field @f{Q}, we can consider the cohomology class:
@e{
   [\mbox{div}\,Q] = \mbox{div}\,Q \quad \mbox{mod}\quad Q(\ldots)
   }
This cohomology class does not depend on the choice of the volume form @f{\mbox{vol}}.

The cohomology class @f{[\mbox{div}\;Q]} plays two importan roles in our approach.
First, they allow to reduce the study of @f{Q} to the first infinitesimal neighborhood of the singularity
locus given by Eq. (@ref{SingularityLocus}). Second, it allows to prove that there is no obstacle
to extending the linearized deformations (the term @f{\epsilon Q_1} in Eq. (@ref{ExpansionOfQAroundFlatSpace}))
to higher orders in @f{\epsilon}. We will now explain this.

@subpage[2 @elem{Requiring @f{\mbox{div}\,Q = 0}} #:tag "sec:FirstInfinitesimalNeighborhood"]

We required that @f{Q} has ghost number one, see Eq. (@ref{QhasGhostNumberOne}). But the ``ghost number''
@f{\lambda_L^{\alpha}{\partial\over\partial\lambda_L^{\alpha}} +
             \lambda_R^{\hat{\alpha}}{\partial\over\partial\lambda_R^{\hat{\alpha}}}}
is coordinate-dependent. It is not invariant under a change of coordinates:
@e{
   \lambda^{\alpha} \mapsto \mbox{polynomial of }\; \lambda
   }
In fact, we can relax Eq. (@ref{QhasGhostNumberOne}) by replacing it with the following two requirements:
@(align
  r.l.n
  `(""
    @,f{Q = 0 \quad \mbox{when} \quad\lambda_L = 0\; \mbox{ or }\; \lambda_R = 0}
    @,label{QisZeroAtLocus})
  `(""
    @,f{[\mbox{div}\;Q] = 0}
    @,label{ZeroDiv})
  )
Indeed Eq. (@ref{QisZeroAtLocus}) implies that @f{Q} is a vector field of ghost number one plus
vector fields of ghost numbers two and higher. 
Although we have not computed @f{H^{>1}\left(\left[Q^{\rm flat},\_\right]\right)},
the results of @cite{Mikhailov:2014qka} suggest that
@e{
   \mbox{div} \;:\;
   H^2\left(\left[Q^{\rm flat},\_\right]\right) \longrightarrow
   H^2\left(Q^{\rm flat},\mbox{functions}\right)
   }
is an isomorphism, and @f{H^{>2}\left(\left[Q^{\rm flat},\_\right]\right)} is zero modulo finite-dimensional spaces.
Then, Eq. (@ref{ZeroDiv}) implies that the terms of the ghost number higher than one in @f{Q} can be removed
by the coordinate redefinition. In other words, the normal form of @f{Q} can be always choosen to be of the ghost nuber one.
It is enough to study the first infinitesimal neighborhood of the singularity locus.



@subpage[2 "Vanishing of obstacles to nonlinear solution" #:tag "sec:VanishingOfObstacles"]

It is necessary to extend this analysis to full nonlinear SUGRA equations,
@italic{i.e.} higher order terms in Eq. (@ref{ExpansionOfQAroundFlatSpace}).
The potential obstacle to extending linearized solutions to the solution of the
nonlinear equation @f{Q^2=0} lies in @f{H^2\left(\left[Q^{\rm flat},\_\right]\right)}.
We will not compute @f{H^2\left(\left[Q^{\rm flat},\_\right]\right)} in this paper,
but the results of @cite{Mikhailov:2014qka} suggest that
@f{H^2\left(\left[Q^{\rm flat},\_\right]\right)}
is actually nonzero.
(We would expect it to be roughly isomorphic to @f{H^1\left(\left[Q^{\rm flat},\_\right]\right)} which we compute here.)
But we also know that the @bold{actual} obstacle is zero, because of the consistency of the nonlinear supergravity
equations of @cite{Berkovits:2001ue}. This means that @f{\{Q_1,Q_1\}} must be a coboundary.
In our language, this can be proven in the following way. 
Let us choose @f{\mbox{vol}} so that the divergence of @f{Q^{\rm flat}} is zero.
The divergence of @f{Q_1}, and therefore of @f{\{Q_1,Q_1\}},
is @f{Q_0}-exact (this statement does not depend on the choice of @f{\mbox{vol}}). This is because @f{\mbox{div} \,Q_1} has
ghost number 1. The cohomology at ghost number 1 is finite-dimensional, and in fact those @f{Q_1} with nonzero
@f{\mbox{div}\,Q_1 \; \mbox{mod}\; Q_0(\ldots)} are non-physical
(see @cite{Mikhailov:2014qka} and references there).
At the same time, the divergence of the elements of @f{H^2\left(\left[Q^{\rm flat},\_\right]\right)}
is nonzero.  Therefore the obstacle actually vanishes. 







@page[ "Notations" #:tag "IntroNotations" #:showtitle #t]

To avoid the discussion of reality conditions, we consider complex vector fields. The notation:
@e[#:label "LinearSpan"]{
   {\bf C}\langle v_1,v_2,\ldots \rangle
   }
means the space of all linear combinations of vectors @f{v_1,v_2,\ldots} with complex coefficients.

We introduce the abbreviated notations:
@(align
  r.l.n
  `(@,f{❨\lambda\theta❩^m \;=\;}
       @,f{\lambda^{\alpha}\Gamma^m_{\alpha\beta}\theta^{\beta}}
       "")
  `(@,f{❨\lambda\theta\theta❩_{\gamma} \;=\;}
       @,f{\lambda^{\alpha}\Gamma^m_{\alpha\beta}\theta^{\beta}\theta^{\delta}\Gamma^{m}_{\delta\gamma}}
       "")
  `(@,f{[v\otimes\psi]^{1/2}_{\alpha} \;=\;}
       @,f{\Gamma^m_{\alpha\beta} v_m \psi^{\beta}}
       "")
  `(@,f{[v\otimes\psi]_{1/2}^{\alpha} \;=\;}
       @,f{\Gamma^{m\alpha\beta} v_m \psi_{\beta}}
       "")
  )

@page["Setup for cohomological perturbation theory" #:tag "CohomologicalPerturbationTheory" #:showtitle #t]

@bystro-local-toc[]

@subpage[1 @elem{Definition of @f{\theta^{\alpha}_L} and @f{\theta^{\hat{\alpha}}_R}} #:tag "sec:DefThetas"]


We @bold{define odd coordinates} @f{\theta} so that:
@e[#:label "DefTheta"
   ]{
     Q_L\theta_L^{\alpha} = \lambda_L^{\alpha} + O(\theta^2),\quad
     Q_L\theta_R^{\hat{\alpha}} = O(\theta^2),\quad
     Q_R\theta_R^{\hat{\alpha}} = \lambda_R^{\hat{\alpha}} + O(\theta^2),\quad
     Q_R\theta_L^{\alpha} = O(\theta^2)
     }

@subpage[1 @elem{Flat @f{Q} and expansion around it} #:tag "sec:FlatQ"]

Flat spacetime corresonds to @f{Q=Q^{\rm flat} = Q^{\rm flat}_L + Q^{\rm flat}_R} where:
@(align
  r.l.n
  `(@,f{Q_L^{\rm flat}\;=\;}
       @,f{\lambda_L{\partial\over\partial\theta_L} + ❨\lambda_L\theta_L❩{\partial\over\partial x}}
       "")
  `(@,f{Q_R^{\rm flat}\;=\;}
       @,f{\lambda_R{\partial\over\partial\theta_R} + ❨\lambda_R\theta_R❩{\partial\over\partial x}}
       "")
  )
Let us consider @f{Q} as a small deformation of @f{Q^{\rm flat}}:
@e[#:label "LinearizedQ"]{
   Q = Q^{\rm flat} + \epsilon Q_1
   }
to the first order in @f{\epsilon}. Such deformations form a linear space. They correspond to
odd vector fields @f{Q_1} satisfying:
@e{
   [Q^{\rm flat} , Q_1] = 0
   }
modulo the equivalence relation, corresponding to the action of diffeomorphisms:
@e{
   Q_1\simeq Q_1 + [Q^{\rm flat},R]
   }
where @f{R} is a ghost number zero vector field on @f{M}.
Therefore, the classification of nilpotent vector fields of the form (@ref{LinearizedQ})
is equivalent to the computation of the
cohomology of the operator @f{[Q^{\rm flat},\_]} on the space of vector fields.

In the rest of this paper we will compute the cohomology of  @f{[Q^{\rm flat},\_]} on the space
of vector fields.

@subpage[1 "Spectral sequence" #:tag "sec:SpectralSequence"]

The grading operator:
@e[#:label "GradingOperator"]{
   N = \theta_L {\partial\over\partial \theta_L} +\theta_R {\partial\over\partial\theta_R}
   + \lambda_L {\partial\over\partial\lambda_L} + \lambda_R {\partial\over\partial\lambda_R}
   }
defines a filtration on the algebra of functions on @f{\mbox{Fun}(M)},
and  on the space of vector fields as a @f{\mbox{Fun}(M)}-module. Let @f{F^N\mbox{Vect}}
be the space of vector fields with grade at least @f{N}. This filtration defines a spectral sequence converging to the cohomology of @f{[Q^{\rm flat},\_]}.

@subpage[1 "First page" #:tag "sec:FirstPage"]

The first page of this spectral sequence is the cohomology of:
@e{
   [Q^{(0)}_L + Q^{(0)}_R\,,\,\_] =
   \left[\lambda_L{\partial\over\partial\theta_L} + \lambda_R{\partial\over\partial\theta_R}\,,\,\_\right]
   }
on the space of vector fields on @f{M}. For a set of coordinates @f{x,y,\ldots} we denote
@f{\mbox{Fun}(x,y,\ldots)} the space of functions of @f{x,y,\ldots} and @f{\mbox{Vect}(x,y,\ldots)}
the space of vector fields (@italic{i.e.} differentiations of @f{\mbox{Fun}(x,y,\ldots)}).
Let us introduce the following complexes:
@(align
  r.l.n
  `(@,f{C_L^{\rm vect}\;=\;} @,elem[#:style 'no-break]{@f{\mbox{Vect}(\theta_L,\lambda_L)} with differential @f{[Q_L^{(0)},\_]}} "")
  `(@,f{C_R^{\rm vect}\;=\;} @,elem[#:style 'no-break]{@f{\mbox{Vect}(\theta_R,\lambda_R)} with differential @f{[Q_R^{(0)},\_]}} "")
  `(@,f{C_L^{\rm fun}\;=\;} @,elem[#:style 'no-break]{@f{\mbox{Fun}(\theta_L,\lambda_L)} with differential @f{Q_L^{(0)}}} "")
  `(@,f{C_R^{\rm fun}\;=\;} @,elem[#:style 'no-break]{@f{\mbox{Fun}(\theta_R,\lambda_R)} with differential @f{Q_R^{(0)}}} "")
  )
Then, @f{\mbox{Vect}(M)} with differential @f{Q_L^{(0)} + Q_R^{(0)}} decomposes as follows:
@(align
  r.l.n
  `(@,f{\mbox{Vect}(M) \;=\;}
       @,f{\phantom{\;\oplus\;} \mbox{Fun}(x) \otimes C_R^{\rm fun}\otimes C_L^{\rm vect}}
       @,label{FunXCRCL})
  `(""
    @,f{\;\oplus\;\mbox{Fun}(x) \otimes C_L^{\rm fun}\otimes C_R^{\rm vect}}
    @,label{FunXCLCR})
  `(""
    @,f{\;\oplus\;\mbox{Fun}(x) \otimes C_L^{\rm fun}\otimes C_R^{\rm fun} \otimes {\partial\over\partial x}}
    @,label{FunXCLCRDx})
  )
(We do not need to take care about the completions of the tensor products, since all our functions
    are polynomials in @f{\theta} and @f{\lambda}.)
The cohomology of @f{C_L^{\rm fun}} and @f{C_R^{\rm fun}} is well known,
see @italic{e.g.} the review part of @cite{Mafra:2009wq}:
@(align
  r.l.n
  `(@,f{H^0(C^{\rm fun})\;=\;} @,f{{\bf C}\langle {\bf 1}\rangle} "")
  `(@,f{H^1(C^{\rm fun})\;=\;}
       @,f{{\bf C}\left\langle
                  ❨\lambda\theta❩,\;[❨\lambda\theta❩\otimes \theta]^{1/2}
                  \right\rangle}
       "")
  `(@,f{H^2(C^{\rm fun})\;=\;}
       @,f{{\bf C}\Big\langle
                  ❨\lambda\theta❩^m❨\lambda\theta❩^n\Gamma_{mn}\theta,\;
                  ❨\lambda\theta❩^m❨\lambda\theta❩^n(\theta\Gamma_{lmn}\theta)
                  \Big\rangle}
       "")
  `(@,f{H^3(C^{\rm fun})\;=\;}
       @,f{{\bf C}\left\langle
                  ❨\lambda\theta❩^l❨\lambda\theta❩^m❨\lambda\theta❩^n (\theta \Gamma_{lmn}\theta)
                  \right\rangle}
       "")
  )
Parts of the cohomology of @f{C_L^{\rm vect}} and @f{C_R^{\rm vect}} which are relevant to this work
will be computed in 〚@seclink["CohomologyQ0"]{@secref{CohomologyQ0}}〛.



@page[@elem{Cohomology of @f{Q^{(0)}} in the space of vector fields} #:tag "CohomologyQ0" #:showtitle #t]

@bystro-local-toc[]

@subpage[1 @elem{Notations} #:tag "sec:Notations"]

Let @f{X} denote the singular supermanifold parametrized by bosonic @f{\lambda^{\alpha}} and fermionic
@f{\theta^{\alpha}} satisfying the pure spinor constraint:
@e[#:label "NotationsPureSpinorConstraint"
   ]{
     \lambda^{\alpha}\Gamma_{\alpha\beta}^m \lambda^{\beta} = 0
     }
(The space @f{M} introduced in 
     〚@seclink["sec:IntroM"]{@secref{sec:IntroM}}〛
     is the direct product of two copies of @f{X}, and the space parametrized by @f{x^m}.)
Let @f{{\cal O}(X)} denote the algebra of polynomial functions on @f{X}, and  @f{Vect(X)= Der(\Oc (X))}
the space of polynomial vector fields. Consider the odd nilpotent vector field @f{Q^{(0)}}:
@e{
   Q^{(0)} = \lambda^{\alpha}{\partial\over\partial\theta^{\alpha}}
   }
The commutation @f{[Q^{(0)},-]} is a nilpotent operator on  @f{Vect(X)}.
We will now compute the cohomology of this operator.

Any vector field @f{V\in  Vec(X)} can be written as
@(align
  r.l.n
  `(@,f{V \;=\;}
       @,f{\xi^{\alpha}(\lambda,\theta) \frac{\p }{\p \l ^\a }  +  u^{\alpha}(\lambda,\theta)\frac{\p }{\p \t ^\a}}
       "")
  `(""
    @,f{(\l \g _m)_\a  \xi^{\alpha}  = 0}
    "")
  )
The condition @f{(\l \g _m)_\a  \xi^{\alpha}  = 0} is needed because @f{\lambda^{\alpha}}
is constrained to satisfy Eq. (@ref{NotationsPureSpinorConstraint}).

Consider the subsheaf @f{U  \subset  TX} consisting of vectors of the form
@f{u^{\alpha}{\partial\over\partial\theta^{\alpha}}}
(in other words, @f{\xi^{\alpha}=0}). Its space of sections is:
@e{
   \Gamma(U) = \{v\in \mbox{Vect}(X) \;|\; {\cal L}_v\lambda^{\alpha} = 0\}
   }
We observe that @f{\Gamma(U)\subset \mbox{Vect}(X)} is invariant under the action of @f{[Q^{(0)},\_]}.
Therefore, we can think of both @f{\Gamma(U)} and @f{\Gamma(TX/U)} as complexes with the differential @f{[Q^{(0)},\_]}.

@subpage[1 @elem{Summary of results for @f{H^1(Vect(X))}} #:tag "sec:SummaryOfH1"]

Using the notations of 〚@seclink["IntroNotations"]{@secref{IntroNotations}}〛:
@(align
  r.l.n
  `(@,f{H^1(Vect(X))_{\rm odd}\;=\;{\bf C}\Big\langle}
       @,f{[❨\lambda\theta❩\otimes\theta]^{1/2}\otimes{\partial\over\partial\theta},}
       @,label{H1VectXOdd})
  `(""
    @,f{❨\lambda\theta❩
        \left(
              \lambda^{\alpha}{\partial\over\partial\lambda^{\alpha}} +
              \theta^{\alpha}{\partial\over\partial\theta^{\alpha}}
              \right)
        \Big\rangle}
    "")

  `(@,f{H^1(Vect(X))_{\rm even}\;=\;{\bf C}\Big\langle}
       @,f{[❨\lambda\theta❩\otimes\theta]^{1/2}\otimes
                                         \left(
                                               \lambda\Gamma_{mn}{\partial\over\partial\lambda} +
                                               \theta\Gamma_{mn}{\partial\over\partial\theta}
                                               \right)
                                         \Big\rangle}
       @,label{H1VectXEven}
       )
  )
In the rest of this Section we will explain the computation.

@subpage[1 @elem{Exact sequences} #:tag "ExactSequences"]

Consider the short exact sequence of complexes:

@e{
   0 \longrightarrow  \Gamma (U)  \longrightarrow  Vect(X) \longrightarrow  \Gamma(TX/U) \longrightarrow  0
   }
The corresponding long exact sequence in cohomology of @f{[Q^{(0)},\_]} is:

@(align
  r.l.n
  `(@,f{\longrightarrow\;}
       @,f{H^{n-1}(\Gamma(U))
              \longrightarrow
              H^{n-1}(Vect(X))
              \longrightarrow
              H^{n-1}(\Gamma(TX/U))
              \longrightarrow}
    "")
  `(@,f{\longrightarrow\;}
       @,f{H^n(\Gamma(U))
              \longrightarrow
              H^n(Vect(X))
              \longrightarrow
              H^n(\Gamma(TX/U))
              \longrightarrow}
       "")
  `(@,f{\longrightarrow\;}
       @,f{H^{n+1}(\Gamma(U))\longrightarrow
             \ldots}
       "")
  )


@bystro-scrbl-only{

@hrule[]

@hrule[]

}

@subpage[1 @elem{Computation of @f{H^1(Vect(X))_{\rm odd}}} #:tag "sec:ComputationH1Odd"]

@subpage[2 "Summary of result" #:tag "sec:SummaryH1odd"]

We use the following segment of the long exact sequence:
@(align
  r.l.n
  `(""
    @,f{H^0(\Gamma(TX/U))_{\rm even}\stackrel{\delta}{\longrightarrow}}
    "")
  `(@,f{\stackrel{\delta}{\longrightarrow}}
       @,f{H^1(\Gamma(U))_{\rm odd}
              \longrightarrow
              H^1(Vect(X))_{\rm odd}
              \longrightarrow
              H^1(\Gamma(TX/U))_{\rm odd}
              \stackrel{\delta}{\longrightarrow}}
       "")
  `(@,f{\stackrel{\delta}{\longrightarrow}}
       @,f{H^2(\Gamma(U))_{\rm even}}
       "")
  )
The cohomology groups participating in this segment have the following description:
@(align
  r.l.n
  `(@,f{H^0(\Gamma(TX/U))_{even} \;=\;}
       @,elem{@f{{\bf C}\langle D, M_{mn} \rangle} of Eq. (@ref{DandM})}
       "")
  `(@,f{H^1(\Gamma(U))_{odd}\;=\;}
       @,f{{\bf C}\left\langle
                  (\lambda\Gamma^m\theta)(\theta\Gamma_m)_{\alpha}{\partial\over\partial\theta^{\beta}}
                  \right\rangle}
       @,label{AnswerH1GUodd})
  `(@,f{\left[\delta\;:\;H^{0}(\Gamma(TX/U))_{even} \longrightarrow H^1(\Gamma(U))_{odd}\right]\;=\;}
       @,elem[#:style 'no-break]{@f{0} 〚@seclink["sec:DeltaH0evenH1odd"]{@secref{sec:DeltaH0evenH1odd}}〛}
       @,label{AnswerDeltaH0evenH1odd})
  `(@,f{H^1(\Gamma(TX/U))_{odd} \;=\;}
    @,f{{\bf C}
        \left\langle
        (\lambda\Gamma^m\theta)\left(\lambda^{\alpha}{\partial\over\partial\lambda^{\alpha}}\right)
        \right\rangle}
    @,label{AnswerGammaTXoverUodd})
  `("" @,elem{〚@seclink["H1DerLambda"]{@secref{H1DerLambda}}〛} "")
  `(@,f{\left[\delta\;:\;H^{1}(\Gamma(TX/U))_{odd} \longrightarrow H^2(\Gamma(U))_{even}\right]\;=\;}
       @,f{0}
       @,label{AnswerDeltaH1oddH2even})
  )
This implies:
@(align
  r.l.n
  `(@,f{H^1(Vect(X))_{\rm odd}\;=\;}
       @,f{H^1(\Gamma(U))_{\rm odd} \oplus H^1(\Gamma(TX/U))_{\rm odd}\;=\;}
       "")
  `(@,f{\;=\;}
       @,f{{\bf C}\left\langle\;
                  (\lambda\Gamma^m\theta)(\theta\Gamma_m)_{\alpha}{\partial\over\partial\theta^{\beta}}
                  \;,\;
                  (\lambda\Gamma^m\theta)
                  \left(
                        \lambda^{\alpha}{\partial\over\partial\lambda^{\alpha}} +
                        \theta^{\alpha}{\partial\over\partial\theta^{\alpha}}
                        \right)
                  \;\right\rangle}
       @,label{AnswerH1VectXodd})
  )

We will now explain the computation.

@subpage[2 "Computation" #:tag "sec:ComputationH1VectOdd"]

@bystro-scrbl-only{
@hrule[]
}

@subpage[3 @elem{@f{\Gamma(TX/U)}} #:tag "sec:GammaTXU"]

The space @f{\Gamma(TX/U)} is generated as an @f{{\cal O}(X)}-module, by the following vector fields:
@e[#:label "DandM"
   ]{
     D = \l ^\a  \frac{\p }{\p \l ^\a } \  ,\quad  M_{mn} = (\l \g _{mn})^\a \frac{\p }{\p \l ^\a }
     }
However @f{\Gamma(TX/U)} is @bold{not} a free @f{{\cal O}(X)} module, because there is a relation:
@e{
   \frac{1}{10}  (\l \g ^{mn})^\a  M_{mn} + \l ^\a  D = 0
   }

@bystro-scrbl-only{
@hrule[]
}


@subpage[3 @elem{@f{\delta\;:\; H^0(\Gamma(TX/U))_{\rm even} \longrightarrow H^1(\Gamma(U))_{\rm odd}}} #:tag "sec:DeltaH0evenH1odd"]

It is zero because both @f{D} and @f{M_{mn}} can be extended to elements of @f{\mbox{Vect}(X)} commuting with
@f{Q^{(0)}}:

@(align
  r.l.n
  `(@,f{D\mapsto }
       @,f{\lambda^{\alpha}{\partial\over\partial\lambda^{\alpha}}
                   + \theta^{\alpha}{\partial\over\partial\theta^{\alpha}}}
       @,label{ExtensionOfD})
  `(@,f{M_{mn} \mapsto}
       @,f{\left(\lambda\Gamma_{mn} {\partial\over\partial \lambda}\right) +
                \left(\theta\Gamma_{mn} {\partial\over\partial \theta}\right)}
       @,label{ExtensionOfM})
  )

@bystro-scrbl-only{
@hrule[]
}

@subpage[3 @elem{@f{H^1(\Gamma(TX/U))_{odd}} and @f{\delta \;:\; H^1(\Gamma(TX/U))_{odd} \rightarrow H^2(\Gamma(U))_{even}}} #:tag "H1DerLambda"]

For any tensor @f{A^{lmn}}, consider vector fields of the form:
@e[#:label "ElementOfC1GTXU"
   ]{
   A^{l,mn}
   (\lambda\Gamma_{l}\theta)
   \left(\lambda\Gamma_m\Gamma_n {\partial\over\partial\lambda}\right)
   }
Such vector fields generate @f{Z^1(\Gamma(TX/U))_{\rm odd}}.
But some of them are @f{Q^{(0)}}-exact:
@e[#:label "TrivialityOfC1GTXU"]{
     (\lambda\Gamma_{[l}\theta)
                    \left(\lambda \Gamma_{m]}\Gamma_n {\partial\over\partial\lambda}
                    \right) =
     {1\over 4}\left[
           Q^{(0)},
           (\theta\Gamma_{lm}\Gamma_p\theta)\left(\lambda \Gamma_p\Gamma_n {\partial\over\partial\lambda}\right)
           \right] \mbox{ \tt\small mod} \; \Gamma(U)
   }
Therefore the vector fields of the form Eq. (@ref{ElementOfC1GTXU}) with @f{A^{lmn}} of the form:
@e[#:label "AZeroInH"
   ]{
     A^{l,mn} = X^{[lm]n} + Y^{l(mn)}\quad , \quad Y^{lmm} = 0
     }
are zero in @f{H^1(\Gamma(TX/U))_{odd}}. This implies that @f{H^1(\Gamma(TX/U))_{odd}} is generated by
the vector fields of the form:
@e[#:label "LambdaThetaDilatation"
   ]{
     (\lambda\Gamma^i\theta)\left(\lambda^{\alpha}{\partial\over\partial\lambda^{\alpha}}\right)
   }
A vector field of Eq. (@ref{ElementOfC1GTXU}) is zero in cohomology iff:
@e[#:label "ProjectionOnH1GTX"
   ]{
   A^{l,lm} - A^{l,ml} - A^{m,ll} = 0
   }
Vector fields of the form (@ref{LambdaThetaDilatation}) correspond to:
@(align
  r.l.n
  `(""
    @,f{A^{l,mn} \;=\;{1\over 10}\delta_{il} \delta_{mn}}
    "")
  `(""
    @,f{A^{l,lm} - A^{l,ml} - A^{m,ll} \;=\; -\delta_{im}}
    "")
  )
Notice that the section of @f{\Gamma(TX/U)} defined by Eq. (@ref{LambdaThetaDilatation}) can be extended
to a @f{[Q^{(0)},\_]}-closed section of @f{TX}:
@e{
   (\lambda\Gamma^m\theta)
   \left(
         \left(\lambda^{\alpha}{\partial\over\partial\lambda^{\alpha}}\right) +
         \left(\theta^{\alpha}{\partial\over\partial\theta^{\alpha}}\right)
         \right)
   }
This means that @f{\delta \;:\; H^1(\Gamma(TX/U))_{odd} \rightarrow H^2(\Gamma(U))_{even}} is zero.

Eq. (@ref{TrivialityOfC1GTXU}) has the following refinement:
@(bystro-scrbl-only
  (marg
   #:scale 0.15
   #:dir "corrected-vector-fields/svgs"
   #:filter (λ (p) (cons? (regexp-match #rx"refinement\\.svg" (path->string p))))
   ))
@(align
  r.l.n
  `(""
    @,f{(\lambda\Gamma_{[l}\theta)
                       \left(
                             \lambda \Gamma_{m]}\Gamma_n {\partial\over\partial\lambda}
                       % [
                          + \theta \Gamma_{m]}\Gamma_n {\partial\over\partial\theta}
                       \right) \;=\;}
    @,label{DownToU})
  `(@,f{\;=\;}
       @,f{
           {1\over 4}\left[
                           Q^{(0)},
                           (\theta\Gamma_{lm}\Gamma_p\theta)
                           \left(
                                 \lambda \Gamma_p\Gamma_n {\partial\over\partial\lambda}
                                 +
                                 {1\over 3} \theta \Gamma_p\Gamma_n {\partial\over\partial\theta}
                                 \right)
                           \right]
           -
           {1\over 6} (\theta\Gamma_p\lambda)\left(\theta\Gamma_p\Gamma_{lm}\Gamma_n{\partial\over\partial\theta}\right)
           }
       "")
  )
@bystro-scrbl-only{

@hrule[]

@hrule[]
}

@subpage[1 @elem{Computation of @f{H^1(\Gamma(TX))_{\rm even}}} #:tag "ComputationH1Even"]

@subpage[2 "Summary of result" #:tag "sec:SummaryH1even"]

@(align
  r.l.n
  `(@,f{H^1(\mbox{Vect}(X))_{\rm even}\;=\;}
       @,f{{\bf C}\Big\langle
                  (\lambda\Gamma^m\theta)\Gamma_{m\alpha\beta}\theta^{\beta}
                  \left(
                        \lambda\Gamma_{kl}{\partial\over\partial\lambda}
                        + \theta\Gamma_{kl}{\partial\over\partial\theta}
                        \right)
                  \Big\rangle}
       @,label{AnswerH1VectXeven})
  )

@subpage[2 "Computation" #:tag "sec:ComputationH1even"]

@bystro-scrbl-only{
@hrule[]
}

We use the following segment of the long exact sequence:
@(align
  r.l.n
  `(""
    @,f{H^0(\Gamma(TX/U))_{\rm odd}\stackrel{\delta}{\longrightarrow}}
    "")
  `(@,f{\stackrel{\delta}{\longrightarrow}}
       @,f{H^1(\Gamma(U))_{\rm even}
              \longrightarrow
              H^1(Vect(X))_{\rm even}
              \longrightarrow
              H^1(\Gamma(TX/U))_{\rm even}
              \stackrel{\delta}{\longrightarrow}}
       "")
  `(@,f{\stackrel{\delta}{\longrightarrow}}
       @,f{H^2(\Gamma(U))_{\rm odd}}
       "")
  )


@bystro-scrbl-only{
@hrule[]
}

@subpage[3 @elem{@f{H^0(\Gamma(TX/U))_{odd}}} #:tag "H0DerLambdaOdd"]
is generated by:
@e{
   Z_{\alpha}^q = (\Gamma_p\theta)_{\alpha}
   \left(\lambda\Gamma^p\Gamma^q{\partial\over\partial\lambda}\right)
}

@bystro-scrbl-only{
@hrule[]
}

@subpage[3 @elem{@f{H^1(\Gamma(U))_{even}}} #:tag "H1GUEven"]
is generated by:
@e{
   Y^m_{\alpha} = (\theta\Gamma^m\lambda) {\partial\over\partial \theta^{\alpha}}
}

@bystro-scrbl-only{
@hrule[]
}

@subpage[3 @elem{Computation of @f{\delta \;:\; H^{0}(\Gamma(TX/U))_{odd} \longrightarrow H^1(\Gamma(U))_{even}}} #:tag "sec:CoboundaryH0OddH1Even"]
@(align
  r.l.n
  `(@,f{\delta Z_{\alpha}^q\;=\;}
       @,f{(\Gamma_p\theta)_{\alpha}
                           \left(\lambda\Gamma^p\Gamma^q{\partial\over\partial\theta}\right)\;=\;}
       ""
       )
  `(@,f{\;=\;}
       @,f{- (\theta\Gamma^p\lambda)
           \left(\Gamma_p\Gamma^q{\partial\over\partial\theta}\right)_{\alpha} \mbox{ mod } [Q^{(0)},\_]
           = - (\Gamma_m\Gamma^q)_{\alpha}^{\beta} Y^m_{\beta} \mbox{ mod } [Q^{(0)},\_]}
       @,label{CoboundaryH0OddH1Even}
       )
  )
The linear map @f{Y^q_{\alpha}\mapsto (\Gamma_m\Gamma^q)_{\alpha}^{\beta} Y^m_{\beta}} is a bijection. More precisely:
@e{
   \left\{
         \lambda{\partial\over\partial\theta}\;,\;
         (\Gamma_p \theta)_{\alpha}\left(
                                         \theta\Gamma^p\Gamma^q{\partial\over\partial\theta} +
                                         2 \lambda\Gamma^p\Gamma^q{\partial\over\partial\lambda}
                                         \right)
         \right\} = - \left(\Gamma_p\Gamma^q \;(\theta\Gamma^p\lambda) {\partial\over\partial\theta}\right)_{\alpha}
         }
@(align
  r.l.n
  `(""
    @,f{
        \left\{
        \lambda{\partial\over\partial\theta}\;,\;
        \left(
              \delta^q_r\Gamma_p\theta - {1\over 10}\Gamma^q\Gamma_r\Gamma_p\theta
              \right)_{\alpha}
        \left(
              \theta\Gamma^p\Gamma^r{\partial\over\partial\theta} +
              2 \lambda\Gamma^p\Gamma^r{\partial\over\partial\lambda}
              \right)
        \right\} \; = 
        }
    "")
  `(@,f{=\;}
       @,f{
           - 2 \left(
                     \left(
                           \delta^q_r - {1\over 10}\Gamma^q\Gamma_r
                           \right)           
                     \;(\theta\Gamma^r\lambda) {\partial\over\partial\theta}
                     \right)_{\alpha}
           }
       "")
  )
@(align
  r.l.n
  `(""
    @,f{
        \left\{
        \lambda{\partial\over\partial\theta}\;,\;
        {1\over 10}(\Gamma^q\Gamma_r\Gamma_p \theta)_{\alpha}
        \left(
              \theta\Gamma^p\Gamma^r{\partial\over\partial\theta} +
              2 \lambda\Gamma^p\Gamma^r{\partial\over\partial\lambda}
              \right)
        \right\} \; = 
        }
    "")
  `(@,f{=\;}
       @,f{
           8 \left(
                   {1\over 10}\Gamma^q\Gamma_r
                   \;(\theta\Gamma^r\lambda) {\partial\over\partial\theta}
                   \right)_{\alpha}
           }
       "")
  )
@(align
  r.l.n
  `(@,f{(\theta\Gamma^q\lambda){\partial\over\partial\theta^{\alpha}}\;=\;}
       @,f{\left\{ \lambda{\partial\over\partial\theta}
                   \;,\;
                   A^q_{\alpha}
                   \right\}
                   }
       "")
  `("" "where" "")
  `(@,f{A^q_{\alpha}\;=\;}
       @,f{- {1\over 2} 
              \left(
                    \delta^q_r\Gamma_p\theta - {1\over 10}\Gamma^q\Gamma_r\Gamma_p\theta
                    \right)_{\alpha}
              \left(
                    \theta\Gamma^p\Gamma^r{\partial\over\partial\theta} +
                    2 \lambda\Gamma^p\Gamma^r{\partial\over\partial\lambda}
                    \right) \;+
              }
       "")
  `(""
    @,f{
        + {1\over 80}(\Gamma^q\Gamma_r\Gamma_p \theta)_{\alpha}
        \left(
              \theta\Gamma^p\Gamma^r{\partial\over\partial\theta} +
              2 \lambda\Gamma^p\Gamma^r{\partial\over\partial\lambda}
              \right)\;=
        }
    "")
  `(@,f{=\;}
       @,f{- {1\over 2} 
              \left(
                    \delta^q_r\Gamma_p\theta - {1\over 8}\Gamma^q\Gamma_r\Gamma_p\theta
                    \right)_{\alpha}
              \left(
                    \theta\Gamma^p\Gamma^r{\partial\over\partial\theta} +
                    2 \lambda\Gamma^p\Gamma^r{\partial\over\partial\lambda}
                    \right)
              }
       "")
  )

 
@(bystro-scrbl-only
  (marg
   #:scale 0.15
   #:dir "corrected-vector-fields/svgs" 
   #:filter (lambda (f)
              (or
               (string-contains? (path->string f) "bijection.svg")
               (string-contains? (path->string f) "delta-Z.svg")
               )
              )
   )
  )

Therefore @f{H^{0}(\Gamma(TX/U))_{odd}} cancels with @f{H^1(\Gamma(U))_{even}}.

@bystro-scrbl-only{
@hrule[]
}


@subpage[3 @elem{Computation of @f{H^1(\Gamma(TX/U))_{\rm even}} and vanishing of  @f{\delta \;:\; H^1(\Gamma(TX/U))_{even} \rightarrow H^2(\Gamma(U))_{odd}}} #:tag "sec:ComputationgH1Even"]

@linebreak[]

The space of cocycles @f{Z^1(\Gamma(TX/U))_{\rm even}} is generated by:
@(align
  r.l.n
  `("" @,f{[❨\lambda\theta❩\otimes\theta]^{1/2} D} "")
  `("" @,f{[❨\lambda\theta❩\otimes\theta]^{1/2} M_{mn}} "")
  )
where @f{D} and @f{M_{mn}} are from Eq. (@ref{DandM}).
Since both @f{D} and @f{M_{mn}} extend to @f{[Q^{(0)},\_]}-closed sections of @f{TX} by Eqs. (@ref{ExtensionOfD})
and (@ref{ExtensionOfM}), the coboundary operator
@f{\delta \;:\; H^1(\Gamma(TX/U))_{even} \rightarrow H^2(\Gamma(U))_{odd}} is zero.

But some cocycles are exact. Indeed, as sections of @f{TX/U}:
@(bystro-scrbl-only
  @(marg #:scale 0.2 #:dir "corrected-vector-fields/svgs" #:filter (lambda (f) (string-contains? (path->string f) "tgggt.svg"))))
@(align
  r.l.n
  `(@,f{Q^{(0)}}
    @,f{\left(
                 \Gamma_{pq}\Gamma_m\theta\,
                 (\theta\Gamma_{kpq}\theta)
                 \left(\lambda \Gamma^k\Gamma^m {\partial\over\partial\lambda}\right)
                 \right)
                \;=\;}
"")
  (bystro-scrbl-only
   `(@,f{\;=\;}
     @,f+0-4{2\Gamma_{pq}\Gamma^k\lambda (\theta\Gamma_{kpq}\theta)
                   \left(\lambda{\partial\over\partial\lambda}\right)
                   +
                   4\Gamma_{nq} \Gamma_m\theta (\theta \Gamma^q\lambda)
                   \left(\lambda\Gamma^n\Gamma^m {\partial\over\partial\lambda}\right)\;=}
"")
   )
  (bystro-scrbl-only
   `(@,f{\;=\;}
     @,f+0-4{2 \Gamma_{kpq}\lambda (\theta\Gamma_{kpq}\theta)
             \left(\lambda{\partial\over\partial\lambda}\right)
             +
             4\Gamma_n \Gamma_q \Gamma_m \theta (\theta \Gamma^q\lambda)
             \left(\lambda\Gamma^n\Gamma^m {\partial\over\partial\lambda}\right)\;=}
"")
   )
  (bystro-scrbl-only
   `(@,f{\;=\;}
     @,f+0-4{2 \Gamma_{kpq}\lambda (\theta\Gamma_{kpq}\theta)
             \left(\lambda{\partial\over\partial\lambda}\right)
             -
             4\Gamma_n \Gamma_m \Gamma_q \theta (\theta \Gamma^q\lambda)
             \left(\lambda\Gamma^n\Gamma^m {\partial\over\partial\lambda}\right)
             +
             8\Gamma_n\theta (\theta\Gamma^m\lambda)
             \left(\lambda\Gamma^n\Gamma^m {\partial\over\partial\lambda}\right)\;=}
"")
   )
  (bystro-scrbl-only
   `(@,f{\;=\;}
     @,f+0-4{2 \Gamma_{kpq}\lambda (\theta\Gamma_{kpq}\theta)
             \left(\lambda{\partial\over\partial\lambda}\right)
             -
             4\Gamma_n \Gamma_m \Gamma_q \theta (\theta \Gamma^q\lambda)
             \left(\lambda\Gamma^n\Gamma^m {\partial\over\partial\lambda}\right)
             +
             16\Gamma_m\theta (\theta\Gamma^m\lambda)
             \left(\lambda {\partial\over\partial\lambda}\right)\;=}
"")
   )
  `(@,f{\;=\;}
    @,f{-32 \Gamma_m\theta(\theta\Gamma^m\lambda)
               \left(\lambda{\partial\over\partial\lambda}\right)
               -
               4\Gamma_n \Gamma_m \Gamma_q \theta (\theta \Gamma^q\lambda)
               \left(\lambda\Gamma^n\Gamma^m {\partial\over\partial\lambda}\right)}
"")
  )


@bystro-scrbl-only{
@hrule[]
}

@page["Coefficients of normal form satisfy wave equations" #:tag "WaveEquations" #:showtitle #t]

@bystro-local-toc[]

Modulo @f{F^4\mbox{Vect}} we can choose the coordinates so that:
@(align
  r.l.n
  `(@,f{Q_L\;=\;}
       @,f{\lambda_L{\partial\over\partial\theta_L}
                    + ❨\lambda_L\theta_L❩^mE^{Ln}_m{\partial\over\partial x^n} \;+}
       @,label{LeadingTermsOfQL1})
  `(""
    @,f{+ \; ❨\lambda_L\theta_L❩^m
          \left(
                \lambda_L \omegaLLL_m \partial_{\lambda_L} + \theta_L \omegaLLL_m \partial_{\theta_L} +
                \lambda_R \omegaLRR_m \partial_{\lambda_R} + \theta_R \omegaLRR_m \partial_{\theta_R} 
                \right)
          \;  +}
    @,label{LeadingTermsOfQL2})
  `(""
    @,f{+ \; ❨\lambda_L\theta_L\theta_L❩
          \left(P_{LL}{\partial\over\partial \theta_L} + P_{LR} {\partial\over\partial \theta_R}\right)
          \mbox{ mod }F^4}
    @,label{LeadingTermsOfQL})
  `(@,f{Q_R\;=\;}
       @,f{\lambda_R{\partial\over\partial\theta_R} +
                    ❨\lambda_R\theta_R❩^mE^{Rn}_m{\partial\over\partial x^{n}}\;+}
       "")
  `(""
    @,f{+ \; ❨\lambda_R\theta_R❩^m
          \left(
                \lambda_R \omegaRRR_m \partial_{\lambda_R} + \theta_R \omegaRRR_m \partial_{\theta_R} +
                \lambda_L \omegaRLL_m  \partial_{\lambda_L} + \theta_L \omegaRLL_m \partial_{\theta_L} 
                \right)
          \;  +}
    "")
  `(""
    @,f{+ ❨\lambda_R\theta_R\theta_R❩
          \left(P_{RL}{\partial\over\partial \theta_L} + P_{RR} {\partial\over\partial \theta_R}\right)
          \mbox{ mod } F^4}
    @,label{LeadingTermsOfQR})
  )
where @f{E,\Omega,P} are some functions of @f{x}.
Indeed, using
〚@seclink["sec:FirstPage"]{@secref{sec:FirstPage}}〛:
@(itemlist
  @item{@f{H^1(C^{\rm fun}_L)_{\rm odd}\otimes {\partial\over\partial x}}
          enters on Line (@ref{LeadingTermsOfQL1}),}
  @item{Second part of @f{H^1(C^{\rm vect}_L)_{\rm odd}} (see Eq. (@ref{AnswerH1VectXodd}))
          and @f{H^1(C^{\rm fun}_L)_{\rm odd}\otimes H^0(C_R^{\rm vect})_{\rm even}}
          on Line (@ref{LeadingTermsOfQL2}),}
  @item{First part of @f{H^1(C_L^{\rm vect})_{\rm odd}} (see Eq. (@ref{AnswerH1VectXodd}))
          and @f{H^1(C_L^{\rm fun})_{\rm even}\otimes H^0(C_R^{\rm vect})_{\rm odd}}
          on Line (@ref{LeadingTermsOfQL})}
  )


@subpage[1 "Equations for tetrad and spin connection" #:tag "sec:EquationsForTetradAndSpinConnections"]

@subpage[2 @elem{Fixing  @f{(so(10)\oplus {\bf C})_L} and @f{(so(10)\oplus {\bf C})_R}} #:tag "sec:FixingFrame"]

Let us study the linearized order in deviations from flat space-time. In flat space-time
@f{E^{L\mu}_m = E^{R\mu}_m = \delta^{\mu}_m}. The deviation from
flatness can be written as:
@e{
   E^{L\mu}_m = \delta^{\mu}_m + \delta^{\mu}_n e^{L}_{n,m}
   \quad \mbox{\tt\small and} \quad
   E^{R\mu}_m = \delta^{\mu}_m + \delta^{\mu}_n e^{R}_{n,m}
   }
where @f{e^L} and @f{e^R} are infinitesimal. We assume summation over repeated indices.
We can choose a freedom of @f{so(10)\oplus {\bf C}} redefinitions
of both @f{(\lambda_L,\theta_L)} and @f{(\lambda_R,\theta_R)} to fix:
@(align
  r.l.n
  `("" @,f{e^L_{[m,n]} = e^R_{[m,n]} \;=\; 0} @,label{BothEAreSymmetric})
  `("" @,f{e^L_{m,m} = e^R_{m,m}} @,label{TraceELisTraceER})
  )
At this point, the only remaining freedom in redefinition of @f{\lambda} and @f{\theta}
is overall rescaling of @f{(\lambda_L,\lambda_R, \theta_L, \theta_R)}.
We fixed both @f{(so(10)\oplus {\bf C})_L \oplus (so(10)\oplus {\bf C})_R}
down to the diagonal @f{\bf C}.

@subpage[2 @elem{Fixing @f{\omegaLLL} and @f{\omegaRRR}} #:tag "sec:FixingOmegaLLLandOmegaRRR"]

According to 〚@seclink["H1DerLambda"]{@secref{H1DerLambda}}〛, we can choose:
@e[#:label "FixingOmegaLLL"
   ]{
     \omegaLLL_{m,lk} = {1\over 10}\omegaLLL^{(s)}_m\delta_{lk}
     }
From @f{\{Q_L,Q_R\} = 0}, the coefficient of
@f{❨\lambda_L\theta_L❩^l❨\lambda_R\theta_R❩^n
                                           \left(
                                                 \lambda_L{\partial\over\partial\lambda_L}
                                                 + \theta_L{\partial\over\partial\theta_L}
                                                 \right)
}, projected to @f{H^1(\Gamma(TX/U))} (see Eq. (@ref{ProjectionOnH1GTX})):
@e[#:label "OmegaLLLvsOmegaRLL"
   ]{
     2\partial_m\omegaRLL_{n,[ml]} - \partial_l\omegaRLL_{n,mm} + \partial_n\omegaLLL^{(s)}_l = 0
     }
Similarly with @f{L\leftrightarrow R}:
@e[#:label "OmegaRRRvsOmegaLRR"
   ]{
     2\partial_m\omegaLRR_{n,[ml]} - \partial_l\omegaLRR_{n,mm} + \partial_n\omegaRRR^{(s)}_l = 0
     }
Eqs. (@ref{FixingOmegaLLL}) and (@ref{OmegaLLLvsOmegaRLL})
and similar equations with @f{L\leftrightarrow R}
determine @f{\omegaLLL} and @f{\omegaRRR} in terms of @f{\omegaRLL} and @f{\omegaLRR}.
Eqs. (@ref{OmegaLLLvsOmegaRLL}) and (@ref{OmegaRRRvsOmegaLRR}) guarantee the cancellation of the obstacle
in @f{H^1(\Gamma(TX/U))_{\rm odd}}, @italic{i.e.} the one containing @f{\partial\over\partial\lambda}.
It remains the coefficient of @f{(\lambda\Gamma^m\theta)(\theta\Gamma_m)_{\alpha}{\partial\over\partial\theta^{\beta}}}
(see Eq. (@ref{AnswerH1VectXodd})).
This will cancel by @f{P_{LL}} and @f{P_{RR}}, see 〚@seclink["EqsRRQLQR"]{@secref{EqsRRQLQR}}〛.

  


Let us denote:
@e{
   \Omega^L_{m,nk} = - \omegaRLL_{m,[nk]} + {1\over 2}\omegaRLL_{m,pp}\delta_{nk}
   }
and similar definition for @f{\Omega^R_{m,nk}} in terms of @f{\omegaLRR}.
@(bystro-scrbl-only
  @(marg
    #:scale 0.5
    #:dir "corrected-vector-fields/svgs"
    #:filter (lambda (f)
               (string-contains? (path->string f) "tetrad.svg")
               )
    )
  )

This notation is useful, because for any vector @f{V_l}:
@e{
   \omegaRLL_{m,nk}V_l\left(\Gamma_n\Gamma_k\Gamma_l + \Gamma_l (\Gamma_n\Gamma_k)^T\right)
   \;=\;
   4V_p \Omega^L_{m,pq} \Gamma_q
   }
From  @f{\{Q_L,Q_R\} = 0}, the coefficient of @f{❨\lambda_L\theta_L❩^m❨\lambda_R\theta_R❩^n{\partial\over\partial x}}:
@(align
  r.l.n
  `(@,f{{\partial\over\partial x^m}E^R_n + E^R_k\Omega^R_{m,kn} \;=\;}
       @,f{{\partial\over\partial x^n}E^L_m + E^L_k\Omega^L_{n,km}}
    "")
  `(@,f{\partial_m e_{Rn,k} + \Omega^R_{m,nk} \;=\;}
       @,f{\partial_n e_{Lm,k} + \Omega^L_{n,mk}}
    "")
  )
Equivalently:
@(align
  r.l.n
  `(""
    @,f{\partial_{[m}(e_L + e_R)_{n],k} + \left(\Omega^L + \Omega^R\right)_{[m,n]k} = 0}
    @,label{TorsionZero})
  `(""
    @,f{\partial_{(m}(e_L - e_R)_{n),k} + \left(\Omega^L - \Omega^R\right){}_{(m,n)k} = 0}
    @,label{AntiTorsionZero})
  )
Eq. (@ref{TorsionZero}) is zero torsion of the ``average'' (@italic{i.e.} left plus right)
connection.

@subpage[2 "Einstein equations" #:tag "sec:EinsteinEquations"]

@(bystro-scrbl-only
  @(marg
    #:scale 0.5
    #:dir "corrected-vector-fields/svgs"
    #:filter (lambda (f)
               (string-contains? (path->string f) "spin-connection.svg")
               )
    )
  )

Let us denote:
@(align
  r.l.n
  `(@,f{g_{mn} \;=\;} @,f{e_{L(m,n)} + e_{R(m,n)}} "")
  `(@,f{\Omega_{m,nk} \;=\;} @,f{{1\over 2}\left(\Omega^L + \Omega^R\right)_{m,nk}} "")
  )
Then Eq. (@ref{TorsionZero}) implies the existence of @f{a_m} such that:
@e[#:label "DefAm"
   ]{
     \Omega_{m,nk} = - g_{m[n}\stackrel{\leftarrow}{\partial}_{k]} + a_m \delta_{nk} - 2 \delta_{m[n}a_{k]}
     }
Infinitesimal coordinate redefinition @f{\tilde{x}^{\mu} = x^{\mu} + \varepsilon v^{\mu}}, followed a compensating rotation
of @f{\theta} and @f{\lambda} in order to preserve Eq. (@ref{BothEAreSymmetric}), corresponds to:
@(bystro-scrbl-only
  @(marg
    #:scale 1.0
    #:dir "corrected-vector-fields/svgs"
    #:filter (lambda (f)
               (string-contains? (path->string f) "diffeomorphism.svg")
               )
    )
  )

@(align
  r.l.n
  `(@,f{\delta_v e_{Lm,k} \;=\;}
       @,f{\delta_v e_{Rm,k} = \partial_{(m} v_{k)}}
       "")
  `(@,f{\delta_v \Omega_{m,nk} \;=\;}
       @,f{\partial_m(\partial_{[n}v_{k]})}
       "")
  `(@,f{\delta\omegaLLL^{(s)}_m \;=\;}
       @,f{2\partial_p \partial_{[p}v_{n]}}
       "")
  )


The overall rescaling
@e[#:label "rescalingGaugeTransformation"]{
   \delta_{\gamma} (\lambda_L,\lambda_R, \theta_L, \theta_R) =
   (\gamma\lambda_L,\gamma\lambda_R, \gamma\theta_L, \gamma\theta_R)
   }
corresponds to:
@(align
  r.l.n
  `(@,f{\delta_{\gamma} g_{m,n} \;=\;}
       @,f{2\gamma\delta_{mn}}
       @,label{RescalingG})
  `(@,f{\delta_{\gamma} a_m \;=\;}
       @,f{-\partial_m\gamma}
       @,label{RescalingA})
  `(@,f{\delta_{\gamma} \Omega_{m,nk} \;=\;}
       @,f{-\partial_m\gamma \delta_{nk}}
       @,label{RescalingO})
  )
From @f{\{Q_L,Q_L\} = 0} and @f{\{Q_R,Q_R\} = 0} follows that @f{\omegaLRR_m} and @f{\omegaRLL_m} both satisfy
Maxwell equations:
@(bystro-scrbl-only
  @(marg
    #:scale 1.0
    #:dir "corrected-vector-fields/svgs"
    #:filter (lambda (f)
               (string-contains? (path->string f) "ddgd.svg")
               )
    )
  )
@e[#:label "MaxwellEquations"
   ]{
     {\partial\over\partial x^n}{\partial\over\partial x^{[m}} \omegaLRR_{n]pq} =
     {\partial\over\partial x^n}{\partial\over\partial x^{[m}} \omegaRLL_{n]pq} = 0
     }
Considering the scalar part, we conclude that @f{a_m} satisfies the Maxwell equations:
@e{
   \partial_m \partial_{[m}a_{n]} = 0
   }
and @f{g_{mn}} satisfies:
@(bystro-scrbl-only
  @(marg
    #:scale 1.0
    #:dir "corrected-vector-fields/svgs"
    #:filter (lambda (f)
               (string-contains? (path->string f) "EinsteinEquations.svg")
               )
    )
  )
@(align
  r.l.n
  `(""
    @,f{\partial_p\partial_{[p}g_{m][n}\stackrel{\leftarrow}{\partial}_{k]} + 2\partial_p \partial_{[p}\delta_{m][n}a_{k]} = 0}
    "")
  `(@,f{\Rightarrow}
       @,f{\partial_k \left(
                            2\partial_{[p}g_{n][m}\stackrel{\leftarrow}{\partial}_{p]} +
                            \partial_m a_n + \delta_{mn} \partial^pa_p
                            \right)
                      - (k\leftrightarrow n) = 0}
       @,label{CurlRicci})
  `(@,f{\Rightarrow}
       @,f{\exists b_m\;:\;
           2\partial_{[p}g_{n][m}\stackrel{\leftarrow}{\partial}_{p]} +
           \partial_m a_n +
           \delta_{mn} \partial^pa_p  
           = - \partial_n b_m}
       "")
  )
It follows from the symmetry @f{m\leftrightarrow n} that exists @f{\phi} such that
@f{b_m  = a_m - \partial_m\phi}. Therefore:
@e[#:label "EqWithAandPhi"
   ]{
     2\partial_{[p}g_{n][m}\stackrel{\leftarrow}{\partial}_{p]} +
     \delta_{mn} \partial^p a_p +
     2\partial_{(m}a_{n)} = \partial_m\partial_n\phi
     }
The rescaling Eqs. (@ref{RescalingG}), (@ref{RescalingA}) and (@ref{RescalingO}) are accompanied by:
@e{
   \delta_{\gamma} \phi = (10-4)\gamma
   }
@(bystro-scrbl-only
  @(marg
    #:scale 0.5
    #:dir "corrected-vector-fields/svgs"
    #:filter (lambda (f)
               (string-contains? (path->string f) "consistency.svg")
               )
    )
  )
With Eq. (@ref{CurlRicci}), the consistency of the sum of Eq. (@ref{OmegaLLLvsOmegaRLL}) and Eq. (@ref{OmegaRRRvsOmegaLRR})
requires, modulo zero modes:
@e{
   \partial_{[m}a_{n]} = 0
   }
and therefore @f{a_m} can be gauged away:
@e{
   a_m = 0
   }
fixing the overall rescaling gauge symmetry of Eq. (@ref{rescalingGaugeTransformation}).

@subpage[2 "Antisymmetric tensor" #:tag "sec:AntisymmetricTensor"]

Eq. (@ref{AntiTorsionZero}) implies, after total symmetrization:
@e[#:label "SymmetrizedDEm"]{
   \partial_{(m}(e_L - e_R)_{n,k)} + \Omega^{L(s)}_{(m}\delta_{nk)} - \Omega^{R(s)}_{(m}\delta_{nk)} = 0
   }
Modulo finite dimensional spaces, Eqs. (@ref{SymmetrizedDEm}), (@ref{AntiTorsionZero}) and (@ref{TraceELisTraceER})  imply that (@italic{cf} Eq. (@ref{GeneralEquationModuloDelta})):
@(align
  r.l.n
  `(@,f{e_L - e_R \;=\;} @,f{0} "")
  `(@,f{\Omega^{L(s)}_m - \Omega^{R(s)}_m \;=\;} @,f{0} @,label{DifferenceOfScalarConnections})
  `(@,f{\left(\Omega^L - \Omega^R\right){}_{(m,n)k} \;=\;} @,f{0}"")
  )
Therefore @f{\Omega^L - \Omega^R} is antisymmetric:
@e{
   \left(\Omega^L - \Omega^R\right)_{k,lm} = H_{klm} = H_{[klm]}
   }
Eqs. (@ref{MaxwellEquations}) imply:
@e[#:label "MaxwellForH"]{
   \partial^p\partial_{[p}H_{q]mn} = 0
   }
@(bystro-scrbl-only
  (marg
   #:scale 1.0
   #:dir "corrected-vector-fields/svgs"
   #:filter (λ (p) (cons? (regexp-match #rx"H\\.svg" (path->string p))))
   ))
The consistency of the difference of Eq. (@ref{OmegaLLLvsOmegaRLL}) and Eq. (@ref{OmegaRRRvsOmegaLRR})
implies  that @f{H_{lmn}} is harmonic:
@e{
   \partial_p\partial^p H_{lmn} = 0
   }
and, modulo a constant, divergenceless:
@e[#:label "DivHisZero"]{
   \partial^p H_{pmn} = 0
   }
Then:
@(bystro-scrbl-only
  (marg
   #:scale 0.15
   #:dir "corrected-vector-fields/svgs"
   #:filter (λ (p) (cons? (regexp-match #rx"plus\\.svg" (path->string p))))
   ))
@e{
   \omegaLLL_l^{(s)} = \omegaRRR_l^{(s)} = 2 \partial_l \phi - 2 \partial_{[l}g_{m]m}
   }



@subpage[1 "Equations for bispinors" #:tag "sec:EquationsForRR"]


@subpage[2 @elem{Equations following from @f{\{Q_L,Q_R\}=0}} #:tag "EqsRRQLQR"]

Considering terms proportional to @f{❨\lambda_R\theta_R❩❨\lambda_L\theta_L\theta_L❩{\partial\over\partial\theta_L}}
and similar terms with @f{L\leftrightarrow R}, we need to require that they cancel similar terms in
〚@seclink["sec:FixingOmegaLLLandOmegaRRR"]{@secref{sec:FixingOmegaLLLandOmegaRRR}}〛.

  


@(align
r.l.n
`(""
  @,f{
      {\partial\over\partial x^m} P_{RR}^{\hat{\alpha}\hat{\beta}} =
      {1\over 6}\partial_{[p} H_{qr]m}\Gamma_{pqr}^{\hat{\alpha}\hat{\beta}}
      + {2\over 3}\partial_m(\partial_l\phi - \partial_{[l}g_{p]p})\Gamma_l^{\hat{\alpha}\hat{\beta}}
      }
  "")
`(""
  @,f{
      {\partial\over\partial x^m} P_{LL}^{\alpha\beta} =
      - {1\over 6}\partial_{[p} H_{qr]m}\Gamma_{pqr}^{\alpha\beta}
      + {2\over 3}\partial_m(\partial_l\phi - \partial_{[l}g_{p]p})\Gamma_l^{\alpha\beta}
      }
  "")
)
This implies that modulo zero modes:
@(align
  r.l.n
  `(""
    @,f{\partial_{[k}H_{lmn]} = 0}
    "")
  `(""
    @,f{
        P_{RR}^{\hat{\alpha}\hat{\beta}} =
        {1\over 18}H_{klm}\Gamma_{klm}^{\hat{\alpha}\hat{\beta}}
        + {2\over 3}(\partial_l\phi - \partial_{[l}g_{p]p})\Gamma_l^{\hat{\alpha}\hat{\beta}}
        }
    "")
  `(""
    @,f{
        P_{LL}^{\alpha\beta} =
        - {1\over 18}H_{klm}\Gamma_{klm}^{\alpha\beta}
        + {2\over 3}(\partial_l\phi - \partial_{[l}g_{p]p})\Gamma_l^{\alpha\beta}        
        }
    "")
  )
The antisymmetric tensor field @f{H_{lmn}} should be identified with the field strength of
the NSNS B-field: @f{H = dB}. 

Now consider the terms proportional to @f{❨\lambda_R\theta_R\theta_R❩❨\lambda_L\theta_L❩{\partial\over\partial\theta_L}}:
@e{
   ❨\lambda_R\theta_R\theta_R❩_{\hat{\alpha}}\;
   \partial_m P_{RL}^{\hat{\alpha}\alpha}\;
   ❨\lambda_L\theta_L❩^m{\partial\over\partial\theta_L^{\alpha}}
   }
It is cancelled by adding:
@e{
   -{1\over 2}
   ❨\lambda_R\theta_R\theta_R❩_{\hat{\alpha}}\;
   \partial_m P_{RL}^{\hat{\alpha}\alpha}\;
   \left(
         \delta^m_r\Gamma_p\theta - {1\over 8}\Gamma^m\Gamma_r\Gamma_p\theta
         \right)_{\alpha}
   \left(
         \theta_L\Gamma^p\Gamma^r{\partial\over\partial\theta_L} +
         2 \lambda_L\Gamma^p\Gamma^r{\partial\over\partial\lambda_L}
         \right)
   }
leading to the extra term:
@e{
   {1\over 3}
   ❨\lambda_R\theta_R\theta_R❩_{\hat{\alpha}}\;
   \partial_m P_{RL}^{\hat{\alpha}\alpha}\;
   \left((4\delta_{mq} - \Gamma_m\Gamma_q)❨\lambda_L\theta_L\theta_L❩\right)_{\alpha}\;
   {\partial\over\partial x^q}
   }
There is a similar contribution with @f{R\leftrightarrow L}. For them to cancel each other, we need:
@(align
  r.l.n
  `(""
    @,f{\Gamma^m_{\alpha\beta}\partial_m P_{RL}^{\hat{\alpha}\beta} = 0}
    "")
  `(""
    @,f{\Gamma^m_{\hat{\alpha}\hat{\beta}}\partial_m P_{LR}^{\alpha\hat{\beta}} = 0}
    "")
  `(""
    @,f{P_{LR}^{\alpha\hat{\alpha}} = P_{RL}^{\hat{\alpha}\alpha}}
    "")
  )


@subpage[2 @elem{Equations for RR bispinor following from @f{\{Q_L,Q_L\}=0}} #:tag "EqsRRQLQL"]

To get @f{\{Q_L, Q_L\} = 0} and @f{\{Q_R, Q_R\} = 0} we need:
@(align
r.l.n
`(""
  @,f{\Gamma^m_{\beta\alpha} {\partial\over\partial x^m} P_{LR}^{\alpha\hat{\alpha}} = 0}
  "")
`(""
  @,f{\Gamma^m_{\hat{\beta}\hat{\alpha}} {\partial\over\partial x^m} P_{RL}^{\alpha\hat{\alpha}} = 0}
  "")
)




@page["Fermionic fields" #:tag "FermionicFields" #:showtitle #t]

In 〚@seclink["WaveEquations"]{@secref{WaveEquations}}〛 we restricted ourselves with @f{Q_L} and @f{Q_R}
parameterized by @bold{even} functions @f{E^{L},E^{R},\ldots}.  We will now add the terms
parameterized by @bold{odd} functions.
According to 〚@seclink["ComputationH1Even"]{@secref{ComputationH1Even}}〛 these terms are:
@(align
  r.l.n
  `(@,f{Q_L'\;=\;}
    @,f{\xi_{LRm}^{\hat{\beta}}(x)
            ❨\lambda_L\theta_L❩^m {\partial\over\partial\theta_R^{\hat{\beta}}}\;+
            ❨\lambda_L\theta_L\theta_L❩_{\alpha} \psi_L^{\alpha\mu}(x) {\partial\over\partial x^{\mu}}\;+
            }
    "")
  `(""
    @,f{+\;\xiLLL^{\alpha [mn]}(x)❨\lambda_L\theta_L\theta_L❩_{\alpha}
    \left(
                       \lambda_L\Gamma_{mn}{\partial\over\partial\lambda_L}
                       + \theta_L\Gamma_{mn}{\partial\over\partial\theta_L}
                       \right)     \;+}
    "")
  `(""
    @,f{+\;\xiLRR^{\alpha mn}(x)❨\lambda_L\theta_L\theta_L❩_{\alpha}
    \left( 
                       \lambda_R\Gamma_m\Gamma_n{\partial\over\partial\lambda_R}
                       + \theta_R\Gamma_m\Gamma_n{\partial\over\partial\theta_R}
                       \right)    \;+\ldots}
    "")
  )
@(align
  r.l.n
  `(@,f{Q_R'\;=\;}
    @,f{\xi_{RLm}^{\beta}(x)
            ❨\lambda_R\theta_R❩^m {\partial\over\partial\theta_L^{\beta}}\;+
            ❨\lambda_R\theta_R\theta_R❩_{\hat{\alpha}} \psi_R^{\hat{\alpha}\mu}(x) {\partial\over\partial x^{\mu}}\;+
            }
    "")
  `(""
    @,f{+\;\xiRRR^{\hat{\alpha} [mn]}(x)❨\lambda_R\theta_R\theta_R❩_{\hat{\alpha}}
    \left(
                       \lambda_R\Gamma_{mn}{\partial\over\partial\lambda_R}
                       + \theta_R\Gamma_{mn}{\partial\over\partial\theta_R}
                       \right)     \;+}
    "")
  `(""
    @,f{+\;\xiRLL^{\hat{\alpha} mn}(x)❨\lambda_R\theta_R\theta_R❩_{\hat{\alpha}}
    \left( 
                       \lambda_L\Gamma_m\Gamma_n{\partial\over\partial\lambda_L}
                       + \theta_L\Gamma_m\Gamma_n{\partial\over\partial\theta_L}
                       \right)    \;+\ldots}
    "")
  )
The first terms in both @f{Q_L'} and @f{Q_R'} are of grade 1, and the rest of the terms are of grade 3.

@subpage[1 "Grade 3 terms are determined by the grade 1 terms" #:tag "sec:Grade3AreFixed"]

Let us first assume that the grade 1 terms are zero, @italic{i.e} @f{\xi_{LRm}^{\hat{\beta}}(x)=0}
and @f{\xi_{RLm}^{\beta}(x)=0}.
Considering the coefficient of @f{❨\lambda_L\theta_L\theta_L❩❨\lambda_R\theta_R❩{\partial\over\partial x}}, we deduce that @f{\psi_L^{\alpha\mu}} satisfies:
@e{
   \partial^{\nu}\psi_L^{\alpha\mu}
   +
   4\xiLRR^{\alpha [\nu\mu]}
   -
   2\xiLRR^{\alpha mm} g^{\mu\nu} 
   = 0
   }
and a similar equation for @f{\psi_R^{\hat{\alpha}\mu}}. This implies
(see  〚@seclink["FiniteDimensionalSolutions"]{@secref{FiniteDimensionalSolutions}}〛)
that modulo finite dimensional subspaces (which we ignore):
@(align
  r.l.n
  `(@,f{\psi_L^{\alpha\mu} \;=\;} @,f{0} "")
  `(@,f{\xiLRR^{\alpha \nu\mu} \;=\;} @,f{0} "")
  `(@,f{\psi_R^{\hat{\alpha}\mu} \;=\;} @,f{0} "")
  `(@,f{\xiRLL^{\hat{\alpha} \nu\mu} \;=\;} @,f{0} "")
  )
The coefficients @f{\xi^{\hat{\alpha}}_{LRm}} and @f{\xi_{RLm}^{\alpha}} come with gauge transformations:
@(align
  r.l.n
  `(@,f{\delta_{\phi_L}\xi_{LRm}^{\hat{\alpha}}\;=\;}
       @,f{\partial_m \phi_L^{\hat{\alpha}}}
       "")
  `(@,f{\delta_{\phi_R}\xi_{RLm}^{\alpha}\;=\;}
       @,f{\partial_m \phi_R^{\alpha}}
       "")
  )
Considering the coefficient of
@f{❨\lambda_L\theta_L\theta_L❩❨\lambda_R\theta_R❩
                              \left(\lambda_L{\partial\over\partial\lambda_L} + \theta_L{\partial\over\partial\theta_L}\right)},
we conclude that @f{\xiLLL^{\alpha [mn]}}
(and similarly @f{\xiRRR^{\hat{\alpha} [mn]}})
are constants, and we ignore them.


@subpage[1 "Grade 1 terms" #:tag "sec:Grade1Terms"]

@subpage[2 @elem{Requiring @f{Q_L^2 = 0}} #:tag "sec:FermionicQLQL"]

Requiring @f{Q_L^2 = 0}, the ``Maxwell bishop move'':
@(align
  r.l.n
  `(""
    @,f{\xi_{LRm}^{\hat{\beta}}(x)❨\lambda_L\theta_L❩^m
            \stackrel{❨\lambda_L\theta_L❩\partial_x}{\longrightarrow}
            \partial_n\xi_{LRm}^{\hat{\beta}}(x)❨\lambda_L\theta_L❩^m❨\lambda_L\theta_L❩^n
            \stackrel{(\lambda_L\partial_{\theta_L})^{-1}}{\longrightarrow}
            \ldots
            \stackrel{❨\lambda_L\theta_L❩\partial_x}{\longrightarrow}}
    "")
  `(@,f{\longrightarrow}
       @,f{\partial^n\partial_{[n}\xi_{LRm]}^{\hat{\beta}}(x)❨\lambda_L\theta_L❩^p❨\lambda_L\theta_L❩^q❨\theta_L\theta_L❩^{pqm}}
    "")
  )
we conclude that @f{\xi_{LR}} (and similarly @f{\xi_{RL}}) should satisfy the Maxwell equations:
@e{
   \partial_m \partial_{[m}\xi_{LRn]} = 0
   }

@subpage[2 @elem{Requiring @f{\{Q_L,Q_R\} = 0}} #:tag "sec:FermionicQLQR"]

We will now consider the anticommutator of @f{Q_R'} with @f{Q_L}. It is convenient to
start by completing @f{\partial\over\partial\theta_L^{\beta}} to
@f{{\partial\over\partial\theta_L^{\beta}} - (\Gamma^m\theta_L)_{\beta}{\partial\over\partial x^m}}.
We have:
@(align
  r.l.n
  `(""
    @,f{
        \left\{\;
        \lambda_L{\partial\over\partial\theta_L} + (\lambda_L\Gamma^m\theta_L){\partial\over\partial x^m}
        \;,\;
        (\lambda_R\Gamma^n\theta_R)
        \xi_{RLn}^{\beta}\left(
                                {\partial\over\partial\theta_L^{\beta}} -
                                (\Gamma^k\theta_L)_{\beta}{\partial\over\partial x^k}
                                \right)
        \;\right\}\;=
        }
    "")
  `(@,f{\;=\;}
       @,f{(\lambda_R\Gamma^n\theta_R)
           {\partial\xi_{RLn}^{\beta} \over\partial x^m}
           (\lambda_L\Gamma^m\theta_L)
           \left(
                 {\partial\over\partial\theta_L^{\beta}} -
                 (\Gamma^k\theta_L)_{\beta}{\partial\over\partial x^k}
                 \right)}
       "")
  )
The term @f{(\lambda_R\Gamma^n\theta_R){\partial\xi_{RLn}^{\beta} \over\partial x^m}(\lambda_L\Gamma^m\theta_L){\partial\over\partial\theta_L^{\beta}}} is removed by further modifying (@italic{cp} Eq. (@ref{CoboundaryH0OddH1Even})):
@e{
   (\theta_R\Gamma^k\lambda_R)\;\xi_{RLk}^{\beta}
       \left[
             {\partial\over\partial\theta_L^{\beta}} - (\Gamma^n\theta_L)_{\beta}{\partial\over\partial x^n}
             \right]
       }
@(bystro-scrbl-only
  (marg
   #:scale 0.15
   #:dir "corrected-vector-fields/svgs"
   #:filter (λ (p) (cons? (regexp-match #rx"fermionic-[1,2]\\.svg" (path->string p))))
   ))
to:
@(align
  r.l.n
  `(""
    @,f{(\theta_R\Gamma^k\lambda_R)\xi_{RLk}^{\beta}
                                   \left[
                                         {\partial\over\partial\theta_L^{\beta}} -
                                         (\Gamma^n\theta_L)_{\beta}{\partial\over\partial x^n}
                                         \right]\;+}
    "")
  `(""
    @,f{+ {1\over 2}(\theta_R\Gamma^k\lambda_R){\partial\xi_{RLk}^{\alpha}\over\partial x^m}
          \left(
                \left(\delta_{mn} - {1\over 8}\Gamma_m\Gamma_n\right)
                \Gamma_p\theta_L
                \right)_{\alpha}
          \left[
                2\lambda_L \Gamma_p\Gamma_n {\partial\over\partial\lambda_L}
                +\theta_L  \Gamma_p\Gamma_n {\partial\over\partial\theta_L}
                \right]}
    "")
  )
Then, when we commute with @f{(\lambda_l\Gamma^m\theta_L){\partial\over\partial x^m}}, this modification produces:
@e{
   {1\over 2}(\theta_R\Gamma^k\lambda_R){\partial\xi_{RLk}^{\alpha}\over\partial x^m}
   \left(
         \left(\delta_{mn} - {1\over 8}\Gamma_m\Gamma_n\right)
         \Gamma_p\theta_L
         \right)_{\alpha}
   (2(\lambda_L \Gamma_p\Gamma_n \Gamma_q\theta_L) + (\theta_L \Gamma_p\Gamma_n \Gamma_q\lambda_L))
   {\partial\over\partial x^q}
   }
which should cancel  @f{-(\lambda_R\Gamma^k\theta_R){\partial\xi_{RLk}^{\alpha} \over\partial x^m}(\lambda_L\Gamma^m\theta_L)(\Gamma^q\theta_L)_{\alpha}{\partial\over\partial x^q}}. Indeed, let us denote:
@e{
   A^{mq}_{\alpha} \;=\;
   - (\lambda_L\Gamma^m\theta_L)(\Gamma^q\theta_L)_{\alpha}
   \; + \;
   {1\over 2}\left(
         \left(\delta_{mn} - {1\over 8}\Gamma_m\Gamma_n\right)
         \Gamma_p\theta_L
         \right)_{\alpha}
   \left(2 (\lambda_L \Gamma_p\Gamma_n \Gamma_q\theta_L) + (\theta_L \Gamma_p\Gamma_n \Gamma_q\lambda_L)\right)
   }
@(bystro-scrbl-only
  (marg
   #:scale 0.15
   #:dir "corrected-vector-fields/svgs"
   #:filter (λ (p) (cons? (regexp-match #rx"QAisZero\\.svg" (path->string p))))
   ))
The total contribution is:
@e[#:label "TotalContributionToCancel"]{
   (\theta_R\Gamma^k\lambda_R){\partial\xi_{RLk}^{\alpha}\over\partial x^m}A_{\alpha}^{mq}{\partial\over\partial x^q}
   }
We observe:
@e{
   \lambda_L{\partial\over\partial\theta_L} A^{mq}_{\alpha} = 0
   }
@(bystro-scrbl-only
  (marg
   #:scale 0.15
   #:dir "corrected-vector-fields/svgs"
   #:filter (λ (p) (cons? (regexp-match #rx"Aalphamq\\.svg" (path->string p))))
   ))
In fact:
@e{
   A^{mq}_{\alpha} \;=\; {1\over 3} \left(\left( 4\delta_{mq} - \Gamma_m \Gamma_q \right)\Gamma_p\theta_L\right)_{\alpha}
   (\lambda_L\Gamma_p\theta_L) + \lambda_L{\partial\over\partial\theta_L}(\ldots)
   }
To cancel Eq. (@ref{TotalContributionToCancel}) we must impose the Dirac equation on @f{\xi^{\alpha}_{RLk}}, in the following sense. 
Require that exists @f{\eta_{RL\alpha}} such that:
@e{
   \Gamma^p_{\alpha\beta}{\partial\over\partial x^p}\xi_{RLk}^{\beta} = {\partial\over\partial x^k} \eta_{RL\alpha}
   }
Then we cancel Eq. (@ref{TotalContributionToCancel}) by choosing
@(align
  r.l.n
  `(@,f{\psi_L^{\alpha q} \;=\;}
       @,f{{1\over 3}\Gamma_q^{\alpha\beta} \eta_{RL\beta} + {4\over 3}\xi^{\alpha}_{RLq}}
       "")
  `(@,f{\xiLRR^{\alpha mq}(x) \;=\;}
       @,f{{4\over 3}\partial_{[m}\xi_{RLq]}^{\alpha}}
       "")
  )
@(bystro-scrbl-only
  (marg
   #:scale 0.15
   #:dir "corrected-vector-fields/svgs"
   #:filter (λ (p) (cons? (regexp-match #rx"Dirac\\.svg" (path->string p))))
   ))
To summarize:
@(align
  r.l.n
  `(@,f{Q_L' \;=\;}
       @,f{❨\lambda_L\theta_L❩^m\xi_{LRm}^{\hat{\beta}}(x)
                                    \left(
                                          {\partial\over\partial\theta_R^{\hat{\beta}}}
                                          -
                                          (\Gamma^n\theta_R)_{\hat{\beta}}
                                          {\partial\over\partial x^n}
                                          \right)\;+
                                    }
       "")
  `(""
    @,f{+\;❨\lambda_L\theta_L❩^k{\partial \xi_{LRk}^{\hat{\beta}}\over\partial x^m}
                             \left(
                                   \left(\delta_{mn} - {1\over 8}\Gamma_m\Gamma_n\right)
                                   \Gamma_p\theta_R
                                   \right)_{\alpha}
                             \left[
                                   2\lambda_R \Gamma_p\Gamma_n {\partial\over\partial\lambda_R}
                                   +\theta_R  \Gamma_p\Gamma_n {\partial\over\partial\theta_R}
                                   \right] +\;
                             }
    "")
  `(""
    @,f{
        +\;❨\lambda_L\theta_L\theta_L❩_{\alpha} \psi_L^{\alpha\mu}(x) {\partial\over\partial x^{\mu}}
        \;+\;
        \partial_{[n}\xi_{LRm]}^{\hat{\beta}}(x)[\theta_R^3\lambda_R]^{[mn]}
        \left(
              {\partial\over\partial\theta_R^{\hat{\beta}}}
              -
              (\Gamma^n\theta_R)_{\hat{\beta}}
              {\partial\over\partial x^n}
              \right)
        \;+
        }
       "")
  `(""
    @,f{+\;\xiLLL^{\alpha [mn]}(x)❨\lambda_L\theta_L\theta_L❩_{\alpha}
                  \left(
                        \lambda_L\Gamma_{mn}{\partial\over\partial\lambda_L}
                        + \theta_L\Gamma_{mn}{\partial\over\partial\theta_L}
                        \right)     \;+}
    "")
  `(""
    @,f{+\;\xiLRR^{\alpha mn}(x)❨\lambda_L\theta_L\theta_L❩_{\alpha}
                  \left( 
                        \lambda_R\Gamma_m\Gamma_n{\partial\over\partial\lambda_R}
                        + \theta_R\Gamma_m\Gamma_n{\partial\over\partial\theta_R}
                        \right)    \;+\ldots}
    "")
  )       
and a similar formula for @f{Q_R'}.



@subpage[1 "Comparison to SUGRA" #:tag "sec:ComparisonToSUGRA"]

The only fermionic superfields of @cite{Berkovits:2001ue} are @f{C^{\alpha\hat{\gamma}}_{\beta}}
and @f{C^{\hat{\alpha}\gamma}_{\hat{\beta}}}. The top component of @f{C^{\alpha\hat{\gamma}}_{\beta}}
corresponds to @f{\partial_{[m}\xi^{\hat{\gamma}}_{LRn]}(\Gamma^{mn})^{\alpha}_{\beta}},
and the top component of @f{\hat{C}^{\hat{\alpha}\gamma}_{\hat{\beta}}} to
@f{\partial_{[m}\xi^{\gamma}_{RLn]}(\Gamma^{mn})^{\hat{\alpha}}_{\hat{\beta}}}.



@page["Supersymmetries and dilatation" #:tag "SUSY" #:showtitle #t]

The vector field @f{Q^{\rm flat}} of Eq. (@ref{QFlat}) is manifestly supersymmetry-invariant.
In other words, it commutes with the super-Poincare algebra, which is generated by
@f{{\partial\over\partial \theta_L^{\alpha}} - \Gamma^m_{\alpha\beta}\theta_L^{\beta} {\partial\over\partial x^m}} and
@f{{\partial\over\partial \theta_R^{\hat{\alpha}}} - \Gamma^m_{\hat{\alpha}\hat{\beta}}\theta_R^{\hat{\beta}} {\partial\over\partial x^m}}. It is also invariant under dilatations, if we define the weight of @f{x}
to be twice the weight of @f{\theta_L}, @f{\theta_R}. It is perhaps less straightforward to see that there
are no other symmetries. For example, there are no conformal symmetries. (But the dilatation symmetry is present.)
We will now prove that there are no other symmetries.

We have to compute the cohomology of @f{Q^{\rm flat}} in the space of vector fields of ghost number @f{0}.
The cohomology of
@f{\lambda_L^{\alpha}{\partial\over\partial\theta_L^{\alpha}} + \lambda_R^{\hat{\alpha}}{\partial\over\partial\theta_L^{\hat{\alpha}}}}
at the ghost number @f{0} is (see 〚@seclink["CohomologyQ0"]{@secref{CohomologyQ0}}〛):
@(align
  r.l.n
  `(@,f{T_m \;=\;}
       @,f{\partial\over\partial x^m}
       "")
  `(@,f{S^L_{\alpha} \;=\;}
       @,f{\partial\over\partial \theta_L^{\alpha}}
       "")
  `(@,f{S^R_{\hat{\alpha}} \;=\;}
       @,f{\partial\over\partial \theta_R^{\hat{\alpha}}}
       "")
  `(@,f{D^L\;=\; }
       @,f{\lambda_L^{\alpha}{\partial\over\partial\lambda_L^{\alpha}}
                   + \theta_L^{\alpha}{\partial\over\partial\theta_L^{\alpha}}}
       "")
  `(@,f{M^L_{mn} \;=\;}
       @,f{\left(\lambda_L\Gamma_{mn} {\partial\over\partial \lambda_L}\right) +
                \left(\theta_L\Gamma_{mn} {\partial\over\partial \theta_L}\right)}
       "")
  `(@,f{D^R\;=\; }
       @,f{\lambda_R^{\hat{\alpha}}{\partial\over\partial\lambda_R^{\hat{\alpha}}}
                   + \theta_R^{\hat{\alpha}}{\partial\over\partial\theta_R^{\hat{\alpha}}}}
       "")
  `(@,f{M^R_{mn} \;=\;}
       @,f{\left(\lambda_R\Gamma_{mn} {\partial\over\partial \lambda_R}\right) +
                \left(\theta_R\Gamma_{mn} {\partial\over\partial \theta_R}\right)}
       "")
  )
This means that any infinitesimal symmetry can be brought to the form:
@(align
  r.l.n
  `(@,f{v\;=\;}
       @,f{T^m(x){\partial\over\partial x^m} +}
       "")
  `(""
    @,f{+\; D_L(x)\left(
                        \lambda_L^{\alpha}{\partial\over\partial\lambda_L^{\alpha}}
                        + \theta_L^{\alpha}{\partial\over\partial\theta_L^{\alpha}}
                        \right)
            +
            M_L^{mn}(x)\left(
                             \left(\lambda_L\Gamma_{mn} {\partial\over\partial \lambda_L}\right) +
                             \left(\theta_L\Gamma_{mn} {\partial\over\partial \theta_L}\right)
                             \right)
            +}
    "")
  `(""
    @,f{+\; D_R(x)\left(\lambda_R^{\hat{\alpha}}{\partial\over\partial\lambda_R^{\hat{\alpha}}}
                                  + \theta_R^{\hat{\alpha}}{\partial\over\partial\theta_R^{\hat{\alpha}}}
                                  \right)
            +
            M_R^{mn}(x)\left(
                             \left(\lambda_R\Gamma_{mn} {\partial\over\partial \lambda_R}\right) +
                             \left(\theta_R\Gamma_{mn} {\partial\over\partial \theta_R}\right)
                             \right)
            +}
    "")
  `(""
    @,f{+\; S_L^{\alpha}(x){\partial\over\partial \theta_L^{\alpha}}
            +
            S_R^{\hat{\alpha}}(x){\partial\over\partial \theta_R^{\hat{\alpha}}}\;+\ldots}
    "")
  )
where @f{\ldots} stand for terms of the higher order in the grading defined by Eq. (@ref{GradingOperator}).
Commuting @f{v} with @f{\left( ❨\lambda_L\theta_L❩^m + ❨\lambda_R\theta_R❩^m \right){\partial\over\partial x^m}},
we have to cancel the coefficients of all generators of @f{[Q^{(0)}_L + Q^{(0)}_R\,,\,\_]}
(see 〚@seclink["sec:FirstPage"]{@secref{sec:FirstPage}}〛).
The vanishing of the coefficient of
@f{❨\lambda_R\theta_R❩^m \left(
                        \lambda_L^{\alpha}{\partial\over\partial\lambda_L^{\alpha}}
                        + \theta_L^{\alpha}{\partial\over\partial\theta_L^{\alpha}}
                        \right)}
implies that @f{D_L(x) = D_{L0}} (constant in @f{x}). Similarly, @f{M^{mn}_L (x) = M^{mn}_{L0}},
@f{D_R(x) = D_{R0}}, @f{M^{mn}_R (x) = M^{mn}_{R0}}.
The vanishing of the coefficient of
@f{❨\lambda_L\theta_L❩^m {\partial\over\partial x^n}}
and
@f{❨\lambda_R\theta_R❩^m {\partial\over\partial x^n}} imply:
@(align
  r.l.n
  `("" @,f{D_{L0} = D_{R0}\;=:D_0} "")
  `("" @,f{M_{L0}^{mn} = M_{R0}^{mn}\;=:M_0^{mn}} "")
  `("" @,f{T^m(x) = T^m_0 + 2D_{0}x^m + M_{0}^{mn} x^n} "")
  )
The vanishing of the coefficients of
@f{❨\lambda_R\theta_R❩{\partial \over\partial\theta_L}}
and
@f{❨\lambda_L\theta_L❩{\partial \over\partial\theta_R}}
imply @f{S_L^{\alpha}(x) = S_{L0}^{\alpha}}
and @f{S_R^{\hat{\alpha}}(x) =S_{R0}^{\hat{\alpha}}} (do not depend on @f{x}).

@(bystro-scrbl-only (image "vector-fields/screenshots/GSW.png"))


@page["Acknowledgments" #:tag "Acknowledments" #:showtitle #t]


This work was supported in part by  ICTP-SAIFR FAPESP grant 2016/01343-7,
and in part by FAPESP grant 2019/21281-4.
We want to thank Nathan Berkovits and Andrey Losev for useful discussions.


@appendix

@page["Higher spin conformal Killing tensors" #:tag "FiniteDimensionalSolutions" #:showtitle #t]

Consider tensor fields on the flat @f{N}-dimensional space @f{{\bf R}^N} with coordinates:
@e{
   x^m \quad,\quad m\in \{1,\ldots,N\}
   }
They are functions with indices: @f{f_{m_1,\ldots m_r}(x)}, where @f{r} is the rank of the tensor.
There are some differential equations which only have finite-dimensional spaces of solutions.
For example:
@e[#:label "SymmetrizedDerivative"
   ]{
     {\partial\over\partial x^{(m}} f_{n)}(x) = 0
     }
The solutions of this equation are parameterized by constant antisymmetric tensors @f{b_{mn}}:
@e{
   f_m = b_{mn} x^n
   }
More generally, consider the equation:
@e[#:label "GeneralEquation"]{
   {\partial\over\partial x^{(m_0}}f_{m_1\ldots m_n)}(x) = 0
   }
We want to classify the solutions of this equation.
Consider the Taylor expansion of @f{f_{m_1\ldots m_n}} near @f{x=0}. Since Eq. (@ref{GeneralEquation}) is
homogeneous in @f{x}, we can consider each order of the Taylor expansion separately. In other words,
it is enough to consider @f{f_{m_1\ldots m_n}(x)} a homogeneous polynomial of @f{x}. 
Let us introduce auxiliary variable @f{y^m} and consider the generating function:
@e[#:label "HatFGeneratingFunction"]{
   \hat{f}(x,y) = y^{m_1}\cdots y^{m_n}f_{m_1\ldots m_n}(x)
   }
Homogeneous polynomials @f{\hat{f}(x,y)} of @f{x,y} of the order @f{N} form a finite-dimensional representation
of @f{sl(2,{\bf R})}, with the generators defined as follows:
@e{
   E = y^m{\partial\over\partial x^m}\,,\;
   F = x^m{\partial\over\partial y^m}\,,\;
   H = y^m{\partial\over\partial y^m} - x^m{\partial\over\partial x^m}
   }
Eq. (@ref{GeneralEquation}) implies that @f{\hat{f}(x,y)} is a highest weigh vector:
@e{
   E\hat{f} = 0
   }
On the other hand, @f{\hat{f}} being a polynomial of the order @f{n} in @f{y} implies:
@e{
   F^{n+1}\hat{f} = 0
   }
Therefore, the space of polynomial solutions of Eq. (@ref{GeneralEquation}) decomposes into the direct
sum of representations of dimension @f{0, 1, 2,\ldots, n}.
They correspond to polynomials of degree @f{0, 1, 2,\ldots, n} in @f{x}.
We conclude that all solutions of Eq. (@ref{GeneralEquation}) are polynomials of order @f{n} in @f{x}
(not necessarily homogeneous).

Let us now consider a weaker equation. Instead of requiring @f{\partial_{(m_0}f_{m_1\ldots m_n)}} be zero,
we require the existence of @f{g_{m_2,\ldots m_n}(x)} such that:
@(align
  r.l.n
  `(""
    @,f{{\partial\over\partial x^{(m_0}}f_{m_1\ldots m_n)}(x) = \delta_{(m_0m_1}g_{m_2\ldots m_n)}(x)}
    @,label{GeneralEquationModuloDelta}
    )
  `(""
    @,f{\delta^{m_1m_2}f_{m_1\ldots m_n} \;=\; 0}
    @,label{Traceless}
    )
  )
(We can think of Eq. (@ref{GeneralEquationModuloDelta}) as having a gauge symmetry
    @f{\delta f_{m_1\ldots m_n} = \delta_{(m_1m_2}h_{m_3\ldots m_n)}},
    @f{\delta g_{m_2\ldots m_n} = \partial_{(m_2}h_{m_3\ldots m_n)}},
    and Eq. (@ref{Traceless}) as fixing the gauge.)
The solutions of Eq. (@ref{GeneralEquationModuloDelta}) are higher spin conformal Killing tensors.
They correspond to traceless Killing tensors in AdS @cite{Mikhailov:2002bp}. Given a traceless
Killing tensor in AdS, we can consider the leading Taylor coefficient of its expansion around
a point in AdS. It will satisfy Eq. (@ref{GeneralEquation})
(with an additional condition @f{\delta^{m_1m_2}f_{m_1m_2\ldots m_n} = 0})
implying that the space of solutions is finite-dimensional.

@bystro-scrbl-only{
@page["Bibliography" #:tag "Bibliography" #:showtitle #t]
}

@(bibliography)



@; ---------------------------------------------------------------------------------------------------
@(bystro-close-connection bystro-conf)
@disconnect[formula-database]

 
 


@; ---------------------------------------------------------------------------------------------------
@(bystro-close-connection bystro-conf)
@disconnect[formula-database]

  
